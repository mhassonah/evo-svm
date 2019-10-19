%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Implementation of a competitive swarm optimizer (CSO) for large scale optimization
%
%  See the details of CSO in the following paper
%  R. Cheng and Y. Jin, A Competitive Swarm Optimizer for Large Scale Optmization,
%  IEEE Transactions on Cybernetics, 2014
%
%  The test instances are the CEC'08 benchmark functions for large scale optimization
%
%  The source code CSO is implemented by Ran Cheng
%
%  If you have any questions about the code, please contact:
%  Ran Cheng at r.cheng@surrey.ac.uk
%  Prof. Yaochu Jin at yaochu.jin@surrey.ac.uk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% begin code
function [bestever,best_individual,convergence_curve]=CSO(population,max_iter,lb,ub,dim,fobj, fitness_type, fs_run_type, trainLabel,trainData)
addpath(genpath(pwd));

global initial_flag

%d: dimensionality
d = dim;
%maxfe: maximal number of fitness evaluations
maxfe = max_iter;

results = zeros(6,1);


% The frist six benchmark functions in  CEC'08  test suite.
% Function 7 is excluded because of the following error thrown by the test suite:
% 'Undefined function 'FastFractal' for input arguments of type 'char'.'

n = d;
initial_flag = 0;

% lu: define the upper and lower bounds of the variables
lu = [lb; ub];

%phi setting (the only parameter in CSO, please SET PROPERLY)
if(d >= 2000)
    phi = 0.2;
elseif(d >= 1000)
    phi = 0.15;
elseif(d >=500)
    phi = 0.1;
else
    phi = 0;
end;

% population size setting
m = population;

% initialization
XRRmin = repmat(lu(1, :), m, 1);
XRRmax = repmat(lu(2, :), m, 1);
rand('seed', sum(100 * clock)); %#ok<RAND>
p = XRRmin + (XRRmax - XRRmin) .* rand(m, d)
fitness = benchmark_func(p,fobj, fitness_type, fs_run_type, trainLabel,trainData);
v = zeros(m,d);
bestever = 1e200;
best_individual = p(1,:);
FES = m;
gen = 1;
convergence_curve=zeros(1,maxfe);

% main loop
while(gen <= maxfe)
    
    % generate random pairs
    rlist = randperm(m);
    rpairs = [rlist(1:ceil(m/2)); rlist(floor(m/2) + 1:m)]';
    
    % calculate the center position
    center = ones(ceil(m/2),1)*mean(p);
    
    % do pairwise competitions
    mask = (fitness(rpairs(:,1)) > fitness(rpairs(:,2)));
    losers = mask.*rpairs(:,1) + ~mask.*rpairs(:,2);
    winners = ~mask.*rpairs(:,1) + mask.*rpairs(:,2);
    
    
    %random matrix
    randco1 = rand(ceil(m/2), d);
    randco2 = rand(ceil(m/2), d);
    randco3 = rand(ceil(m/2), d);
    
    % losers learn from winners
    v(losers,:) = randco1.*v(losers,:) ...,
        + randco2.*(p(winners,:) - p(losers,:)) ...,
        + phi*randco3.*(center - p(losers,:));
    p(losers,:) = p(losers,:) + v(losers,:);
    
    % boundary control
    for i = 1:ceil(m/2)
        p(losers(i),:) = max(p(losers(i),:), lu(1,:));
        p(losers(i),:) = min(p(losers(i),:), lu(2,:));
    end
    
    % fitness evaluation
    fitness(losers,:) = benchmark_func(p(losers,:),fobj, fitness_type, fs_run_type,trainLabel,trainData);
    [~, rank] = min(fitness);
    
    if (min(fitness) < bestever)
        best_individual = p(rank,:);
    end;
    
    bestever = min(bestever, min(fitness));
    convergence_curve(gen)= bestever;
    fprintf('Best fitness: %e\n', bestever);
    FES = FES + ceil(m/2);
    gen = gen + 1;
end;
