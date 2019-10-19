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

function [accuracy] = svm_train(x, train_label, train_data)

%% Get cost and gamma
[cost, gamma] = adjust_cost_gamma (x(1),x(2));

%% Set SVM parameters and get performance measure
% #1 for accuracy only, with inner cross-validation:
para_svmtrain =['-c',' ', num2str(cost) ,' ','-g',' ', num2str(gamma) , ...
    ' -b 0 -q -h 0 -v 3' ];
accuracy = svmtrain(train_label, train_data, para_svmtrain);

% #2 for accuracy, mse, rmse, mae, without inner cross-validation:
% para_svmpredict =['-c',' ', num2str(cost) ,' ','-g',' ', num2str(gamma) , ...
%     ' -b 0 -q -h 0' ];
% model = svmtrain(train_label, train_data,  para_svmpredict);
% [predicted_label, measures,~] ...
%    = svmpredict(train_label, train_data, model,'-b 0 -q');
%[mse, rmse, mae] = get_eval_measures(train_label, predicted_label); %#ok<ASGLU>
% accuracy = measures(1);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
