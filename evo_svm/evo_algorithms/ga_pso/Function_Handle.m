function [InitFunction, CostFunction, FeasibleFunction] = Function_Handle

InitFunction = @Function_Handle_Init;
CostFunction = @Function_Handle_Cost;
FeasibleFunction = @Function_Handle_Feasible;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MaxParValue, MinParValue, Population, OPTIONS] = Function_Handle_Init(OPTIONS)

global MinParValue MaxParValue
Granularity = 0.1;
MinParValue = 0.01;
MaxParValue = 1;
%MaxParValue = floor(1 + 2 * 2.048 / Granularity);
% Initialize population
for popindex = 1 : OPTIONS.popsize
    chrom = (MinParValue + (MaxParValue - MinParValue) * rand(1,OPTIONS.numVar));
    Population(popindex).chrom = chrom;
end
OPTIONS.OrderDependent = true;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Population] = Function_Handle_Cost(OPTIONS, Population,fitness_type, trainLabel,trainData)

global MinParValue MaxParValue
popsize = OPTIONS.popsize;
for popindex = 1 : popsize
   
        
        Population(popindex).cost=cost(Population(popindex).chrom, fitness_type, trainLabel,trainData);
end
return
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = Function_Handle_Feasible(OPTIONS, Population)

global MinParValue MaxParValue

for i = 1 : OPTIONS.popsize
    for k = 1 : OPTIONS.numVar
        Population(i).chrom(k) = max(Population(i).chrom(k), MinParValue);
        Population(i).chrom(k) = min(Population(i).chrom(k), MaxParValue);
    end
end
return;
        
        
