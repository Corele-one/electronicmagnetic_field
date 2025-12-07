k = 8.9980e9;
q=1e-10;
L = 8;
Np = 180;
x = linspace(-L,L,Np);
y = linspace(-L,L,Np);
[X,Y] = meshgrid(x,y);
hold on
d = 3;
r1 = sqrt((X-d).^2 + (Y-d).^2);
r2 = sqrt((X+d).^2 + (Y-d).^2);
r3 = sqrt((X+d).^2 + (Y+d).^2);
r4 = sqrt((X-d).^2 + (Y+d).^2);
% 电势计算
u = k*q*(1./r1 - 1./r2 + 1./r3 - 1./r4);
S = -10:0.1:10;
[M,c] = contour(X,Y,u,S,'--');
c.LineWidth = 1;
colormap(nebula);
grid on
hold on
[Ex,Ey] = gradient(-u);% 计算电场分量
t = linspace(0,2*pi,21);%确定电场线角度步进
rd = 0.15;%电场线起点半径
start_x1 = d + rd*cos(t);%电场线起点x坐标
start_y1 = d + rd*sin(t);%电场线起点y坐标
for i = 1:21
    he = streamline(X,Y,Ex,Ey,start_x1(i),start_y1(i));%计算电场线
    hold on
    arrowPlot(he.XData,he.YData,'number',1,'color','b','LineWidth',2);%绘制带箭头电场线
    hold on
end
% 为其他三个电荷添加电力线起点并绘制（颜色为绿色）
start_x2 = -d + rd*cos(t);
start_y2 = d + rd*sin(t);
for i = 1:21
    he2 = streamline(X,Y,Ex,Ey,start_x2(i),start_y2(i));
    hold on
    arrowPlotn(he2.XData,he2.YData,'number',1,'color','g','LineWidth',2);
    hold on
end    
start_x3 = -d + rd*cos(t);
start_y3 = -d + rd*sin(t);
for i = 1:21
    he3 = streamline(X,Y,Ex,Ey,start_x3(i),start_y3(i));
    hold on
    arrowPlot(he3.XData,he3.YData,'number',1,'color','m','LineWidth',2);
    hold on
end    
start_x4 = d + rd*cos(t);
start_y4 = -d + rd*sin(t);
for i = 1:21
    he4 = streamline(X,Y,Ex,Ey,start_x4(i),start_y4(i));
    hold on
    arrowPlotn(he4.XData,he4.YData,'number',1,'color','c','LineWidth',2);
    hold on
end
q1 = plot(d,d,'k+','MarkerSize',8,'LineWidth',2);
q2 = plot(-d,d,'k_','MarkerSize',8,'LineWidth',2);
q3 = plot(-d,-d,'k+','MarkerSize',8,'LineWidth',2);
q4 = plot(d,-d,'k_','MarkerSize',8,'LineWidth',2);
legend([q1,q2,q3,q4],{'+q at (d,d)','-q at (-d,d)','+q at (-d,-d)','-q at (d,-d)'},'Location','best');
title('四个点电荷在直角导体边角处的电势分布及电力线');
xlabel('x (m)');
ylabel('y (m)');
