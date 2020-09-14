%显示线路脚本，运行main脚本后可直接运行该脚本可查看线路

global position_map;
global route_all_map;
global dot_label;



route_id = inputdlg('输入线路编号线路, 多条时请用空格分开:','工具');

%显示公交车站
figure3 = figure('name','线路图');
scatter(position_map(1, index_A),position_map(2,index_A),100,'o','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 0])
hold on;
scatter(position_map(1, index_B),position_map(2,index_B),100,'s','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 1])
scatter(position_map(1, index_C),position_map(2,index_C),100,'p','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 1])
scatter(position_map(1, index_D),position_map(2,index_D),100,'^','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 0])
axis([4 55 0 55]);

temp_pos = position_map';
text(temp_pos(:,1)+0.5,temp_pos(:,2)+0.1,dot_label);
if ~isempty(route_id)
    num = str2num(route_id{1});
    name = cell(1,size(num,2));
    for i=1:size(num,2)
        a=(position_map(:,route_all_map{num(i)}))';
        if i==1
            p=plot(a(:,1),a(:,2),'-.','linewidth',2);
        else
            p=[p plot(a(:,1),a(:,2),'-.','linewidth',2)];
        end
        name{i}=['线路：',num2str(num(i))];
    end
    legend(p,name,'Location','southeast');
end









