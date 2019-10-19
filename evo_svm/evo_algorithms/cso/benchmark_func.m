function fit=benchmark_func(x, fobj, fitness_type, fs_run_type, trainLabel, trainData)

[rows, ~] = size(x);
for i = 1:rows
    fit(i,:)= fobj(x(i,:), fitness_type, fs_run_type, trainLabel,trainData);
end;

%%%%% end of file %%%%%