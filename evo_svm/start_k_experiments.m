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

function [all_accuracies, all_best_cost,all_best_gamma, avg_accuracy, ...
    std_accuracy, all_mse, avg_mse, ...
    std_mse, all_rmse, avg_rmse, ...
    std_rmse, all_mae, avg_mae , std_mae, ...
    all_recall_first, std_recall_first, avg_recall_first, ...
    all_recall_second, std_recall_second, avg_recall_second, ...
    all_precision_first, std_precision_first, avg_precision_first, ...
    all_precision_second, std_precision_second, avg_precision_second, ...
    all_f_measure, std_f_measure, avg_f_measure, ...
    all_g_mean, std_g_mean, avg_g_mean, ...
    all_num_of_feats, avg_num_of_feats, std_num_of_feats, ...
    convergence_points, all_TP, all_FN, all_FP, all_TN, all_best_indiv] ...
    = start_k_experiments(dataset, ext, algo, dir_data, k, fitness_type, ...
    fs_run_type, population, max_iteration, lower_bound, upper_bound)

%% Read the data set
% Initialization
label = zeros; inst = zeros;

% Specify format
if (strcmpi(ext,'') == 1)
    [label, inst] = libsvmread(fullfile(dir_data, dataset));
elseif (strcmpi(ext,'.csv') == 1) % label is in first column -
    % % % % % % % % % % % % % % % % to change: go to read_csv.m
    [label, inst] = read_csv(dir_data, dataset);
else
    return;
end

[N, D] = size(inst);

%% making k partitions
c = cvpartition(N,'KFold',k);

%% Start k-experiments
parfor i=1:k;
    
    train_index = zeros(N,1); train_index(find(training(c,i))) = 1; %#ok<FNDSB>
    test_index = zeros(N,1); test_index(find(test(c,i))) = 1; %#ok<FNDSB>
    train_data = inst(train_index==1,:); %#ok<*PFBNS>
    train_label = label(train_index==1,:);
    test_data = inst(test_index==1,:);
    test_label = label(test_index==1,:);
    
    % Best solution and convergence for training set
    [best_solution, convergence] = init_evo(train_label,train_data,D, ...
        algo, fitness_type, population, max_iteration, lower_bound, ...
        upper_bound, fs_run_type);
    
    % Storing convergence points
    if (strcmp(fitness_type,'maximization') == 1)
        convergence_points(i,:) = 100 - convergence; %#ok<*AGROW>
    elseif (strcmp(fitness_type,'minimization') == 1)
        convergence_points(i,:) = convergence;
    end
    
    % Separating Cost, Gamma and other individuals
    [best_cost, best_gamma, individuals] = dismantle (best_solution, D);
    
    % Adjusting range of cost and gamma
    [cost, gamma] = adjust_cost_gamma (best_cost, best_gamma);
    
    % Initialize SVM parameters
    para =strjoin(strcat('-c',{' '},num2str(cost) ,{' '},'-g',{' '}, ...
        num2str(gamma) ,' -b 0 -q -h 0' ));
    
    % Get training model
    if (strcmp(fs_run_type, 'with'))
        [selected_train_data, ~] = select_features(individuals,train_data);
    elseif (strcmp(fs_run_type, 'without'))
        selected_train_data = train_data;
    else %% Other later cases
        selected_train_data = train_data;
    end
    
    % Get the model of the best individual one more final time.
    model = svmtrain(train_label, selected_train_data, para);
    
    display(sprintf('\n'));
    display(strcat('Testing accuracy for fold number', num2str(i), ':'));
    
    % Get testing accuracy from SVM
    if (strcmp(fs_run_type, 'with'))
        [selected_test_data, ~] = select_features(individuals,test_data);
    elseif (strcmp(fs_run_type, 'without'))
        selected_test_data = test_data;
    else %% Other later cases
        selected_test_data = test_data;
    end
    
    [predicted_label, eval_measure,~] = svmpredict(test_label, ...
        selected_test_data, model, '-b 0');
    [mse, rmse, mae] = get_eval_measures(test_label, predicted_label);
    display(sprintf('\n'));
    
    % Get confusion matrix
    [cmt, ~] = confusionmat(test_label, predicted_label);
    [confusion_mat]=clean_confusion_mat(cmt, train_label);
    
    TP = confusion_mat(1);
    FN = confusion_mat(2);
    FP = confusion_mat(3);
    TN = confusion_mat(4);
    
    recall_f = TP /(TP + FN);
    recall_s = TN /(TN + FP);
    precision_f = TP / (TP + FP);
    precision_s = TN / (TN + FN);
    f_measure = 2 *((recall_f * precision_f) / (recall_f + precision_f));
    g_mean = sqrt(recall_f * recall_s);
    
    % Collecting Values
    all_accuracies(i,:)= eval_measure(1);
    all_best_cost(i,:)= cost;
    all_best_gamma(i,:)= gamma;
    all_mse(i,:) = mse;
    all_rmse(i,:) = rmse;
    all_mae(i,:) = mae;
    all_best_indiv(i,:) = individuals;
    all_recall_first(i,:) = recall_f * 100;
    all_recall_second(i,:) = recall_s * 100;
    all_precision_first(i,:) = precision_f * 100;
    all_precision_second(i,:) = precision_s * 100;
    all_f_measure(i,:) = f_measure * 100;
    all_g_mean(i,:) = g_mean * 100;
    all_TP(i,:) = TP;
    all_FN(i,:) = FN;
    all_FP(i,:) = FP;
    all_TN(i,:) = TN;
    
    if (strcmp(fs_run_type, 'with'))
        all_num_of_feats(i,:) = get_feature_count(individuals);
    elseif (strcmp(fs_run_type, 'without'))
        all_num_of_feats(i,:) = D;
    else %% Other later cases
        all_num_of_feats(i,:) = D;
    end
    
end

%% Calculating average & std
std_accuracy = std(all_accuracies);
avg_accuracy= mean(all_accuracies);

std_num_of_feats = std(all_num_of_feats);
avg_num_of_feats = mean(all_num_of_feats);

std_mse = std(all_mse);
avg_mse= mean(all_mse);

std_rmse = std(all_rmse);
avg_rmse= mean(all_rmse);

std_mae = std(all_mae);
avg_mae= mean(all_mae);

all_recall_first(isnan(all_recall_first))= 0;
std_recall_first = std(all_recall_first);
avg_recall_first = mean(all_recall_first);

all_recall_second(isnan(all_recall_second))= 0;
std_recall_second = std(all_recall_second);
avg_recall_second = mean(all_recall_second);

all_precision_first(isnan(all_precision_first))= 0;
std_precision_first = std(all_precision_first);
avg_precision_first = mean(all_precision_first);

all_precision_second(isnan(all_precision_second))= 0;
std_precision_second = std(all_precision_second);
avg_precision_second = mean(all_precision_second);

all_f_measure(isnan(all_f_measure))= 0;
std_f_measure = std(all_f_measure);
avg_f_measure = mean(all_f_measure);

all_g_mean(isnan(all_g_mean))= 0;
std_g_mean = std(all_g_mean);
avg_g_mean = mean(all_g_mean);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%