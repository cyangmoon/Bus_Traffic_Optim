%计算目标函数值
function FunctionValue = objective( )

global population;
global y_kj_all;
global q_gj_all;
global station_population;
global station_studyers;
global station_workers;
global frequency;
global distance_station;
global speed;
global z_gi;
global t_g;
global t_k;
global distance_route;


c1=0;
c2=0;
c3=0;

 for k1=1:13
     for j1=1:66
         c1=c1 + population(:,k1).*y_kj_all(k1,j1).*(station_population(j1)+station_studyers(j1)+station_workers(j1));
     end
 end
 
 
 c2_1=0;
 c2_2=0;
 c2_3=0;
 for k2=1:13
     for j2=1:66
         for g2=1:9
             c2_1=c2_1+population(:,k2).*y_kj_all(k2,j2).*q_gj_all(g2,j2).*distance_station(j2,1)./speed;
             
             c2_3=c2_3 + population(:,k2).*y_kj_all(k2,j2).*q_gj_all(g2,j2);
             
             for i2=1:frequency
                 c2_2=c2_2+population(:,k2).*y_kj_all(k2,j2).*q_gj_all(g2,j2).*z_gi(g2,i2).*(t_k(frequency)-t_g(g2));
             end
         end
     end
 end
 c2 = (c2_1+c2_2)./c2_3;
     
 
 for k3=1:13
     c3 = c3+2*(population(:,k3).*distance_route(k3).*frequency./speed);
 end
 
 %对目标函数1取反，将最大值问题转化为最小值问题
 FunctionValue=[-c1 c2  c3];
end
