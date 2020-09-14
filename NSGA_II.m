
global population;
global Generations;
global FunctionValue;
global num_population;
global FrontValue;


FunctionValue = objective();  %计算目标向量函数值
FrontValue = NonDominateSort(FunctionValue,0); % 进行非支配排序
CrowdDistance = CrowdDistances(FunctionValue,FrontValue);%计算聚集距离

if draw_iteration_flag ~= 0
    figure2=figure();
    scatter3(FunctionValue(:,1),FunctionValue(:,2),FunctionValue(:,3));
    xlabel('f1','FontSize',16);
    ylabel('f2','FontSize',16);
    zlabel('f3','FontSize',16);
end


%开始迭代
for Gene = 1 : Generations
    %产生子代。
    MatingPool = Select(population,FrontValue,CrowdDistance); %交配池选择。2的锦标赛选择方式
    Offspring = Cross_mutation(MatingPool); %交叉,变异，越界处理并生成新的种群
    
    population = [population;Offspring];  %种群合并
    
    FunctionValue = objective();%计算目标函数值
    [FrontValue,MaxFront] = NonDominateSort(FunctionValue,1); % 进行非支配排序
    CrowdDistance = CrowdDistances(FunctionValue,FrontValue);%计算聚集距离
    
    
    %选出非支配的个体
    Next = zeros(1,num_population);
    NoN = numel(FrontValue,FrontValue<MaxFront);
    Next(1:NoN) = find(FrontValue<MaxFront);
    
    %选出最后一个面的个体
    Last = find(FrontValue==MaxFront);
    [~,Rank] = sort(CrowdDistance(Last),'descend');
    Next(NoN+1:num_population) = Last(Rank(1:num_population-NoN));
    
    %下一代种群
    population = population(Next,:);
    FrontValue = FrontValue(Next);
    CrowdDistance = CrowdDistance(Next);
    FunctionValue = objective();
    
    %绘制迭代图
    if draw_iteration_flag ~= 0
        figure(figure2);
        scatter3(FunctionValue(:,1),FunctionValue(:,2),FunctionValue(:,3));
        title(['位置迭代次数：', num2str(Gene)]);
    end
end

