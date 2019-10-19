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

function [cmt_checked] = clean_confusion_mat(cmt, label) 

label_count = numel(unique(label));
[i, j] = size (cmt);

if (i<label_count && j<label_count)
    cmt(label_count,:)= 0;
    cmt(:,label_count)= 0;
    cmt_checked=cmt;
else
    cmt_checked=cmt;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%