%bus_traffic_optimation entry
%clear; close all;clc;  %不清除数据可在第一次运行后，减少加载数据时间，从而加快运行
format compact;

global num_population;
global Generations;
global speed;
global frequency;
global t_k;
global t_g;
global ProC;
global ProM;
global population;
global FunctionValue;
global draw_iteration_flag;
global num_flag;
global FrontValue;

%参数设置
draw_routeMap_flag=0;   %是否绘制---所有候选线路图---,为0为不绘制
draw_iteration_flag=0;  %是否绘制---函数目标值迭代图---，为0为不绘制
num_flag = 3;           %接入线路条数，可分别设置为1、2、3
num_population = 50;    %种群数,为便于交叉配对，种群须为偶数
Generations = 20;       %迭代次数
ProC = 0.8;             %交叉概率
ProM = 0.3;             %变异概率
speed=20;               %公车运行速度
frequency=3;            %定义发车频率与时间；
t_k=18+[11/60,31/60,51/60];       %公交发车时间表
t_g = 18+[5/60,11.5/60 18/60 24.4/60 31/60 ... %地铁到站时间表
    37.5/60 44/60 50.5/60 57/60];



load_excel_data;            %初始化数据
initial_candidate_routes;   %初始化候选线路
if draw_routeMap_flag ~= 0
    figure1 = draw_routeMap();
end
if num_flag==1
    population = eye(13);
    FunctionValue = objective;
    [FrontValue,~] = NonDominateSort(FunctionValue,1); % 进行非支配排序
elseif num_flag==2 || num_flag==3
    population = false(num_population,13);
    for pop_index = 1:num_population
        temp_x = false(1,13);
        temp_x(randperm(13,num_flag))=1;
        while domain_limit(temp_x)==0
            temp_x = false(1,13);
            temp_x(randperm(13,num_flag))=1;
        end
        population(pop_index,:) = temp_x;
    end
    NSGA_II;
else
    error("num_flag：须为1、2、3");
end
show_result();%在命令行显示结果

answer = questdlg('是否打开线路显示用具?','','是','否','否');
if answer =='是'
   route_tool; 
end


