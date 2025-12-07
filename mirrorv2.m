%假设点电荷q=2C位于无限大导体平板上方1.2m
%试求点电荷q=2C对无限大接地导体平板的镜像电荷位置与电场强度分布。
clc
clear all
e=1.602e-19;
h=1.2;
q1=2;
q2=-q1;
ep=8.85*1e-12;
k=9.0e9;
a=3;
[x,y]=meshgrid(-a:0.01:a,-a:0.01:a);
r1=sqrt(x.^2+(y-h).^2);
r2=sqrt(x.^2+(y+h).^2);
U=k*e*(q1./r1+q2./r2);
u0=k*e/5;
v=linspace(-4,4,16)*u0;
contour(x,y,U,v,'-');

[Ex,Ey]=gradient(-U);
hold on
plot(0,h,'o','MarkerSize',5);
plot(0,-h,'o','MarkerSize',5);
hp = plot([-a,a],[0,0],'k','linewidth',2);
title('点电荷对无限大接地导体平面的镜像');
xlabel('x');
ylabel('y');
Ne=21;
t=linspace(0,2*pi,Ne);
rd=0.08;
start_x1=rd*cos(t);
start_y1=h+rd*sin(t);
for i=1:Ne
    he=streamline(x,y,Ex,Ey,start_x1(i),start_y1(i));
    pipi=arrowPlot(he.XData,he.YData,'number',1,'color','b','LineWidth',2);
    hold on;
end
% 为镜像电荷添加电力线起点并绘制（颜色为绿色）
start_x2 = rd*cos(t);
start_y2 = -h + rd*sin(t);
for i=1 : Ne
    he2 = streamline(x,y,Ex,Ey,start_x2(i),start_y2(i));
    set(he2,'LineWidth',1);
    pipi=arrowPlotn(he2.XData,he2.YData,'number',1,'color','g','LineWidth',2);
    hold on;
end
hReal = plot(0,h,'r+','MarkerSize',12,'LineWidth',2);
% 显示镜像电荷位置
hImage = plot(0,-h,'r_','MarkerSize',12,'LineWidth',2);
% 添加虚拟线条句柄以便图例显示电力线颜色
hRealLines = plot(nan,nan,'b','LineWidth',1.5);
hImageLines = plot(nan,nan,'g','LineWidth',1.5);
legend([hp,hReal,hImage,hRealLines,hImageLines],{'Conductor plane','Real charge','Image charge','Field lines (real)','Field lines (image)'},'Location','best');
hold off