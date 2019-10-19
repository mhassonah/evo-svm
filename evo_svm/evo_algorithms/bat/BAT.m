% ======================================================== % 
% Files of the Matlab programs included in the book:       %
% Xin-She Yang, Nature-Inspired Metaheuristic Algorithms,  %
% Second Edition, Luniver Press, (2010).   www.luniver.com %
% ======================================================== %    

% -------------------------------------------------------- %
% Bat-inspired algorithm for continuous optimization (demo)%
% Programmed by Xin-She Yang @Cambridge University 2010    %
% -------------------------------------------------------- %
% Usage: bat_algorithm([20 1000 0.5 0.5]);                 %


% -------------------------------------------------------------------
% This is a simple demo version only implemented the basic          %
% idea of the bat algorithm without fine-tuning the parameters,     % 
% Then, though this demo works very well, it is expected that       %
% this demo is much less efficient than the work reported in        % 
% the following papers:                                             %
% (Citation details):                                               %
% 1) Yang X.-S., A new metaheuristic bat-inspired algorithm,        %
%    in: Nature Inspired Cooperative Strategies for Optimization    %
%    (NISCO 2010) (Eds. J. R. Gonzalez et al.), Studies in          %
%    Computational Intelligence, Springer, vol. 284, 65-74 (2010).  %
% 2) Yang X.-S., Nature-Inspired Metaheuristic Algorithms,          %
%    Second Edition, Luniver Presss, Frome, UK. (2010).             %
% 3) Yang X.-S. and Gandomi A. H., Bat algorithm: A novel           %
%    approach for global engineering optimization,                  %
%    Engineering Computations, Vol. 29, No. 5, pp. 464-483 (2012).  %
% -------------------------------------------------------------------


% Main programs starts here

function [fmin, best, Convergence_curve]=BAT (population,Max_iter,lb, ub, dim, fitness_type, fs_run_type, trainLabel,trainData)
%function [best,Convergence_curve]=BAT(dim,net,inputs,targets)
% Display help

%[Max_iter,ub,lb,N] = loadParameters();

% Default parameters
%if nargin<1,  para=[20 1000 0.5 0.5];  end
n=population;      % Population size, typically 10 to 40
N_gen=Max_iter;  % Number of generations
A=0.5;      % Loudness  (constant or decreasing)
r=0.5;      % Pulse rate (constant or decreasing)
% This frequency range determines the scalings
% You should change these values if necessary
Qmin=0;         % Frequency minimum
Qmax=2;         % Frequency maximum
% Iteration parameters
N_iter=0;       % Total number of function evaluations
% Dimension of the search variables
d=dim;          % Number of dimensions 
% Lower limit/bounds/ a vector
Lb=lb; %*ones(1,d);
% Upper limit/bounds/ a vector
Ub=ub; %*ones(1,d);


% Initializing arrays
Q=zeros(n,1);   % Frequency
v=zeros(n,d);   % Velocities
Convergence_curve=[];
% Initialize the population/solutions
for i=1:n,
  Sol(i,:)=Lb+(Ub-Lb).*rand(1,d);
  Fitness(i)=cost(Sol(i,:), fitness_type, fs_run_type, trainLabel,trainData);
end
% Find the initial best solution
[fmin,I]=min(Fitness);
best=Sol(I,:);

% ======================================================  %
% Note: As this is a demo, here we did not implement the  %
% reduction of loudness and increase of emission rates.   %
% Interested readers can do some parametric studies       %
% and also implementation various changes of A and r etc  %
% ======================================================  %
ImpactArray=[];
% Start the iterations -- Bat Algorithm (essential part)  %
for t=1:N_gen, 
% Loop over all bats/solutions
        for i=1:n,
          Q(i)=Qmin+(Qmin-Qmax)*rand;
          v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
          S(i,:)=Sol(i,:)+v(i,:);
          % Apply simple bounds/limits
          Sol(i,:)=simplebounds(Sol(i,:),Lb,Ub);
          % Pulse rate

          if rand>r
          % The factor 0.001 limits the step sizes of random walks 
              S(i,:)=best+0.001*randn(1,d);
          end
    
          S(i,:)=simplebounds(S(i,:),Lb,Ub);
          
     % Evaluate new solutions
           Fnew=cost(S(i,:), fitness_type, fs_run_type, trainLabel,trainData);
     % Update if the solution improves, or not too loud
           if (Fnew<=Fitness(i)) & (rand<A) ,
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
           end
         
          % Update the current best solution
          if Fnew<=fmin,
                best=S(i,:);
                fmin=Fnew;
          end
           
        end

        N_iter=N_iter+n;

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     Temp= round(S(:,3:end));
     Impact=sum(Temp,1);
     ImpactArray=[ImpactArray;Impact];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Convergence_curve(t)=fmin;
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
disp(['Best =',num2str(best),' fmin=',num2str(fmin)]);

% Application of simple limits/bounds
function s=simplebounds(s,Lb,Ub)
  % Apply the lower bound vector
 

  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % Apply the upper bound vector 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  % Update this new move 
  s=ns_tmp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Objective function: your own objective function can be written here
% Note: When you use your own function, please remember to 
%       change limits/bounds Lb and Ub (see lines 52 to 55) 
%       and the number of dimension d (see line 51). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function z=Fun(u)
%% Sphere function with fmin=0 at (0,0,...,0)
%z=sum(u.^2);
%%%%% ============ end ====================================


