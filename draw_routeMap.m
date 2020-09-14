function figure1 = draw_routeMap()
%绘制车站坐标点
global position_map;
global dot_label;
global index_A;global index_B;global index_C;global index_D;
global route_all_map
figure1=figure('name','bus_station_position');
hold on;
scatter(position_map(1, index_A),position_map(2,index_A),75,'o','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 0])
scatter(position_map(1, index_B),position_map(2,index_B),75,'s','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 1])
scatter(position_map(1, index_C),position_map(2,index_C),75,'p','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 1])
scatter(position_map(1, index_D),position_map(2,index_D),75,'^','LineWidth',1,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 0])
axis([4 55 0 55]);
for i=1:13
    route_map =  route_all_map{i};
    temp_x = position_map(1,route_map);
    temp_y = position_map(2,route_map);
    plot(temp_x,temp_y,'-.','linewidth',2);
end
legend('A','B','C','D','route-1','route-2','route-3','route-4','route-5','route-6','route-7','route-8','route-9',...
        'route-10','route-11','route-12','route-13','location','southeast');
    legend('boxoff');
temp_pos = position_map';
text(temp_pos(:,1)+0.5,temp_pos(:,2)+0.1,dot_label);    %标记点
hold off;
end

