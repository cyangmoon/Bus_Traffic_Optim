%候选路线站点与总长的输入

global candidate_route; %候选路线实体
global distance_route;  %候选路线线长
global route_all_map;   %候选线路编号映射值
global dot_label;       %车站标签向量
global z_gi;
global y_kj_all;
global frequency;
global t_g;
global t_k;
if isempty(distance_route)
    distance_route = [4.3 5.51 5.21 5.49 5.19 4.81 4.79 4.51 4.49 4.5 4.2 4.4 4.7];
    candidate_route_1 = {'C5','A18','C4','D1','D2','D3','D5','D6','D7','D8','D9'};
    candidate_route_2 = {'C5','A19','A20','A22','A23','A24','B4','B5','A33','B6','B7','B8','B9','B11','B12','B13'};
    candidate_route_3 = {'C5','A19','A20','B1','B2','A32','A33','B6','B7','B8','B9','B11','B12','B13'};
    candidate_route_4 = {'C5','A19','A20','A22','A23','A24','B4','B5','A33','B6','B7','B8','B9','B11','B12'};
    candidate_route_5 = {'C5','A19','A20','B1','B2','A32','A33','B6','B7','B8','B9','B11','B12'};
    candidate_route_6 = {'C5','A19','A20','A22','A23','A24','B4','B5','A33','B6','B7','B8','B9','B11'};
    candidate_route_7 = {'C5','A19','A20','B1','B2','A32','A33','B6','B7','B8','B9','B11'};
    candidate_route_8 = {'C5','A19','A20','A22','A23','A24','B4','B5','A33','B6','B7','B8','B9'};
    candidate_route_9 = {'C5','A19','A20','B1','B2','A32','A33','B6','B7','B8','B9'};
    candidate_route_10 = {'C5','A16','A11','A10','A7','C2','A8','C1','A5','A2','A1','A3'};
    candidate_route_11 = {'C5','A16','A11','A10','A7','C2','A8','C1','A5','A2','A1'};
    candidate_route_12 = {'C5','A11','B14','B15','C1','A5','A2','A1'};
    candidate_route_13 = {'C5','A16','B14','B15','C1','A5','A2','A1','A3'};
    candidate_route={candidate_route_1,candidate_route_2,candidate_route_3,candidate_route_4,candidate_route_5,...
        candidate_route_6,candidate_route_7,candidate_route_8,candidate_route_9,candidate_route_10,...
        candidate_route_11,candidate_route_12,candidate_route_13};
    for candidate_index = 1:13
        temp_route_index = candidate_route{candidate_index};
        route_size = size(temp_route_index,2);
        route_map = zeros(1,route_size);
        for index = 1:route_size
            no_station =temp_route_index{index};
            prename = no_station(1);
            switch prename
                case 'A'
                    route_map(index) = str2double(no_station(2:end));
                case 'B'
                    route_map(index) = str2double(no_station(2:end))+size(index_A,2);
                case 'C'
                    route_map(index) = str2double(no_station(2:end))+size(index_A,2)+size(index_B,2);
                case 'D'
                    route_map(index) = str2double(no_station(2:end))+size(index_A,2)+size(index_B,2)+size(index_C,2);
            end
        end
        route_all_map{candidate_index,1} = route_map;
    end
    dot_label = [];
    for i=1:9
        dot_label = [dot_label;['A',num2str(i),' ']];
    end
    for i=10:33
        dot_label = [dot_label;['A',num2str(i)]];
    end
    for i=34:42
        dot_label = [dot_label;['B',num2str(i-33),' ']];
    end
    for i=43:48
        dot_label = [dot_label;['B',num2str(i-33)]];
    end
    for i=49:56
        dot_label = [dot_label;['C',num2str(i-48),' ']];
    end
    for i=57:65
        dot_label = [dot_label;['D',num2str(i-56),' ']];
    end
    dot_label = [dot_label;['D',num2str(10)]];
end

%对于特定候选线路，确定y_kj的逻辑值
y_kj_all=false(size(route_all_map,1),66);
for index  = 1:13
    y_kj = false(1,66);
    y_kj(1,route_all_map{index})=1;
    y_kj_all(index,:)=y_kj;
end

%z_gi用于地铁到站后乘客就近选择发车时间的逻辑变量
z_gi = zeros(9,frequency);
for g=1:9
    temp_z = find(t_k>t_g(g)+6/60);
    if ~isempty(temp_z)
        z_gi(g,temp_z(1))=1;
    end
end
