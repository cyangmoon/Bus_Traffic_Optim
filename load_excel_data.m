
%加载excel中的数据

global position_map;    %由经纬度坐标变换得到的绘图坐标点
global distance_station;
global index_A;global index_B;global index_C;global index_D;    %车站分类索引
global station_population;  %车站人口
global station_workers;     %就业岗位数
global station_studyers;    %就学岗位数
global q_gj_all;            %客流量

if isempty(position_map)
    index_A=1:33; index_B=34:48; index_C=49:56;index_D=57:66;
    input_filename = '数据表格';
    sheet1 = '坐标';
    position=zeros(2,66);
    RangeA = 'B2:B34';RangeB = 'E2:E16';RangeC = 'H2:H9';RangeD = 'K2:K11';
    position(1,index_A) = xlsread(input_filename,sheet1,RangeA);
    position(1,index_B) = xlsread(input_filename,sheet1,RangeB);
    position(1,index_C) = xlsread(input_filename,sheet1,RangeC);
    position(1,index_D) = xlsread(input_filename,sheet1,RangeD);
    RangeA = 'C2:C34';RangeB = 'F2:F16';RangeC = 'I2:I9';RangeD = 'L2:L11';
    position(2,index_A) = xlsread(input_filename,sheet1,RangeA);
    position(2,index_B) = xlsread(input_filename,sheet1,RangeB);
    position(2,index_C) = xlsread(input_filename,sheet1,RangeC);
    position(2,index_D) = xlsread(input_filename,sheet1,RangeD);
    position_map = 1000*(position - repmat(min(position,[],2),1,66))+5;
    
    sheet2 = '到各个站点距离';
    Range_distance = 'B2:B67';
    distance_station = xlsread(input_filename,sheet2,Range_distance);
    
    sheet3= '人口和岗位数';
    Range_population='C2:C67';Range_work='D2:D67';Range_study='E2:E67';
    station_population=xlsread(input_filename,sheet3,Range_population);
    station_workers=xlsread(input_filename,sheet3,Range_work);
    station_studyers=xlsread(input_filename,sheet3,Range_study);
    
    q_gj_all=zeros(9,66);
    sheet4='客流需求';
    RangeA = 'B2:AH10';RangeB = 'B12:P20';RangeC = 'B22:I30';RangeD = 'B32:K40';
    q_gj_all(:,index_A)=xlsread(input_filename,sheet4,RangeA);
    q_gj_all(:,index_B)=xlsread(input_filename,sheet4,RangeB);
    q_gj_all(:,index_C)=xlsread(input_filename,sheet4,RangeC);
    q_gj_all(:,index_D)=xlsread(input_filename,sheet4,RangeD);
end