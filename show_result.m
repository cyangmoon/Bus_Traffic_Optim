function show_result()
%显示结果

persistent msg_flag;
global population;
global FunctionValue;
global FrontValue;
global num_flag;
global candidate_route;
global frequency;

msg_flag = 0;

need1=find(FrontValue ==1);
pareto_population = population(need1,:);
pareto_FunctionN_Value = FunctionValue(need1,:);
[sorted_1_pareto_FunctionValue,ranked_1]  = sortrows(pareto_FunctionN_Value);
sorted_1_pareto_population = pareto_population(ranked_1,:);
disp(['-----------------------------','接入线路为',num2str(num_flag),'、发车频率为',num2str(frequency),'时: 结果---------------------------']);
disp('                  -----------pareto解集(根据目标函数值f1排序-----------               ');
for i=1:size(sorted_1_pareto_population,1)
    index = find(sorted_1_pareto_population(i,:)==1);
    switch num_flag
        case 1
            disp(['第 ',num2str(i),' ','方案为:   ',...
                '线路 ',num2str(index(1)),'    ',...
                '多目标函数值：    ',num2str(-sorted_1_pareto_FunctionValue(i,1)),'      ',num2str(sorted_1_pareto_FunctionValue(i,2)),'      ',num2str(sorted_1_pareto_FunctionValue(i,3))]);
        case 2
            disp(['第 ',num2str(i),' ','方案为:   ',...
                '线路 ',num2str(index(1)),'    ',...
                '线路 ',num2str(index(2)),'    ',...
                '多目标函数值：    ',num2str(-sorted_1_pareto_FunctionValue(i,1)),'      ',num2str(sorted_1_pareto_FunctionValue(i,2)),'      ',num2str(sorted_1_pareto_FunctionValue(i,3))]);
        case 3
            disp(['第 ',num2str(i),' ','方案为:   ',...
                '线路 ',num2str(index(1)),'    ',...
                '线路 ',num2str(index(2)),'    ',...
                '线路 ',num2str(index(3)),'    ',...
                '多目标函数值：    ',num2str(-sorted_1_pareto_FunctionValue(i,1)),'      ',num2str(sorted_1_pareto_FunctionValue(i,2)),'      ',num2str(sorted_1_pareto_FunctionValue(i,3))]);
    end
end

[final_singe_FunctionValue,normalized_FuncationValue,weight] = mult_to_oneObjective(sorted_1_pareto_FunctionValue);

disp('目标函数归一化矩阵(和上面方案一一对应): ');
disp(char(num2str(normalized_FuncationValue)));
disp('熵权法计算得到的权重值：');
disp(char(num2str(weight)));
disp('目标函数距离(和上面方案一一对应): ');
disp(char(num2str(final_singe_FunctionValue)));


[sorted_2_final_singe_FunctionValue,ranked_2] = sortrows(final_singe_FunctionValue);
sorted_2_pareto_FunctionValue = sorted_1_pareto_FunctionValue(ranked_2,:);
sorted_2_pareto_population = sorted_1_pareto_population(ranked_2,:);

num_sort = '';
num = '';
for i=1:size(sorted_2_pareto_population,1)
    num_sort = [num_sort,num2str(i),'           '];
    num = [num,num2str(ranked_2(i)),'           '];
end

disp('                 --------------理想点法单目标：结果--------------               ');
disp('其中方案编号为: 上面显示的pareto解集方案编号');

disp(['排序：      ',num_sort]);
disp(['方案编号：  ',num]);
disp(['目标值大小：',num2str(sorted_2_final_singe_FunctionValue')]);

aa = find(sorted_2_pareto_population(1,:)==1);    %获取最优值的组合线路
route_str = cell(1,3);
for j=1:num_flag
    temp = candidate_route{aa(j)};
    route_str1 = '';
    for i=1:size(temp,2)
        if i==1
            route_str1 = [route_str1 , temp{i}];
        else
            route_str1 = [route_str1,'→',temp{i}];
        end
    end
    route_str{1,j}=route_str1;
end
switch num_flag
    case 1
        disp(['最优线路为第 ',num2str(aa(1)),' 条:  ',route_str{1}]);
    case 2
        disp(['最优组合线路为： ',' 方案',num2str(ranked_2(1)),',  候选路线分别为:']);
        disp(['       ',num2str(aa(1)),'  :  ',route_str{1}]);
        disp(['       ',num2str(aa(2)),'  :  ',route_str{2}]);
    case 3
        disp(['最优组合线路为： ',' 方案',num2str(ranked_2(1)),',  候选路线分别为:']);
        disp(['       ',num2str(aa(1)),'  :  ',route_str{1}]);
        disp(['       ',num2str(aa(2)),'  :  ',route_str{2}]);
        disp(['       ',num2str(aa(3)),'  :  ',route_str{3}]);
end
if msg_flag ~= 0
    helpdlg('在命令行中输入: route_tool 可显示线路信息','提示');
end

end
