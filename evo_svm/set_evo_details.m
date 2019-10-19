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

function [lb,ub,dim,fobj] = ...
    set_evo_details(D, lower_bound, upper_bound)

%% Initilialization
fobj = @get_cost;
dim = D+2;
lb = zeros(1,dim) + lower_bound;
ub = ones(upper_bound,dim);

end

%% Get fintess value
function o = get_cost(x, fitness_type, fs_run_type, tr_Data, tr_label)

o=cost(x, fitness_type, fs_run_type, tr_Data, tr_label);

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%