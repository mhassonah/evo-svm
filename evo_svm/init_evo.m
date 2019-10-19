%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%  Developed in Matlab R2015a  (8.5.0. 196713)                            %
%                                                                         %
%  Developed by: Mohammad A. Hassonah, Ala' M. Al-Zoubi and Hossam Faris  %
%                                                                         %
%  e-Mails: mohammad.a.hassonah@gmail.com, alaah14@gmail.com,             %
%           7ossam@gmail.com                                              %
%                                                                         %
%  Main paper:                                                            %
%   Faris, H., Hassonah, M. A., Ala'M, A. Z., Mirjalili, S.,			  %
%	& Aljarah, I. (2018). A multi-verse optimizer approach for feature    %
%	selection and optimizing SVM parameters based on a robust system      %
%	architecture. Neural Computing and Applications, 30(8), 2355-2369.    %
%                                                                         %
%  DOI: https://doi.org/10.1007/s00521-016-2818-2                         %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Best_pos,convergence] = ...
    init_evo(trainLabel,trainData,D,algo, fitness_type, population, ...
    max_iteration, lower_bound, upper_bound, fs_run_type)

%% Initialize details
[lb,ub,dim,fobj]=set_evo_details(D, lower_bound, upper_bound);

%% Run Algorithm(s)
switch algo
    case 1 % MVO
        [~,Best_pos,convergence]= MVO(population, max_iteration,lb, ub, ...
            dim, fobj, fitness_type, fs_run_type, trainLabel,trainData);
    case 2 % GA
        [~,Best_pos,convergence]=GA(dim,population,max_iteration, ...
            fitness_type, fs_run_type, trainLabel,trainData);
    case 3 % PSO
        [~,Best_pos,convergence]=PSO(dim,population,max_iteration,...
            fitness_type, fs_run_type, trainLabel,trainData);
    case 4 % DA
        [~,Best_pos,convergence]=DA(population, max_iteration,lb,ub, ...
            dim, fobj, fitness_type, fs_run_type, trainLabel,trainData);
    case 5 % GOA
        [~,Best_pos,convergence]=GOA(population, max_iteration, ...
            lower_bound, upper_bound, dim, fobj, fitness_type, ...
            fs_run_type, trainLabel, trainData);
    case 6 % SCA
        [~,Best_pos,convergence]=SCA(population, max_iteration,lb, ub, ...
            dim, fobj, fitness_type, fs_run_type, trainLabel,trainData);
    case 7 % SSA
        [~,Best_pos,convergence]=SSA(population, max_iteration, ...
            lower_bound, upper_bound,dim, fobj, fitness_type, fs_run_type, ...
            trainLabel, trainData);
    case 8 % WOA
        [~,Best_pos,convergence]=WOA(population, max_iteration,lb, ub, ...
            dim, fobj, fitness_type, fs_run_type, trainLabel, trainData);
    case 9 % FA
        [Best_pos,convergence]=FA(population, max_iteration,lb, ub, dim, ...
            fitness_type, fs_run_type, trainLabel, trainData);
    case 10 % BAT
        [~,Best_pos,convergence]=BAT(population, max_iteration, lb, ub, ...
            dim, fitness_type, fs_run_type, trainLabel, trainData);
	case 11 % CSO
        [~,Best_pos,convergence]=CSO(population, max_iteration, lb, ub, ...
            dim, fobj, fitness_type, fs_run_type, trainLabel, trainData);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%