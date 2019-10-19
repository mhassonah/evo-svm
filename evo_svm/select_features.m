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

function [train_features, selected_features_numbers] = select_features(individuals,train_data)

[~, D] = size(train_data);

binary_individuals= round(individuals);
A= full(train_data);
count=1;
selected_features_numbers = zeros(1,D);

for i=1:D
    if sum(binary_individuals(1:D))>=1 % we check the sum from 1 to D to
                                       % avoid extra possible vector length
                                       % added by any of the evo algorithms
        if binary_individuals(:,i)==1
            train_features(:,count)= A(:,i); %#ok<AGROW>
            selected_features_numbers (: ,i) = i;
            count=count+1;
        end
    else
        train_features (:,i)= A(:,i); %#ok<AGROW>
    end
end

selected_features_numbers(end+1:D+1)=0;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%