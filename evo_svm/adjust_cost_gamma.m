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

function [adjusted_cost,adjusted_gamma] = adjust_cost_gamma (cost, gamma)

%% EQUATION: New value(adjusted) = (((Old Value - Old Min) * New Range) / Old Range) + New Min

%% Old range for both Cost and Gamma = (Old Max - Old Min)
old_range = (1 - 0.01);
old_min = 0.01;

%% Value of new Cost -- Adjust new minimum & new maximum cost here
new_min_cost = 0.01;
new_max_cost = 35000.0;
new_range_cost = (new_max_cost - new_min_cost);
adjusted_cost = ...
    (((cost - old_min) * new_range_cost) / old_range) + new_min_cost;

%% Value of new Gamma -- Adjust new minimum & new maximum gamma here
new_min_gamma = 0.0001;  
new_max_gamma = 32.0;
new_range_gamma = (new_max_gamma - new_min_gamma);
adjusted_gamma = ...
    (((gamma - old_min) * new_range_gamma) / old_range) + new_min_gamma;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%