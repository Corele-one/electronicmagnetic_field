%%点电荷位于不接地导体球外
%假设半径为a=1cm的不接地导体球外有一个点电荷q=1x10^(-10)C,点电荷距离球心d=2cm,求球外的电位与电场强度分布。
clear
k = 8.985e9;
ra = 0.01;
d = 0.02;
x0 = 0.04;
q1 = 1e-10;
q2 = -ra/d*q1;%q2为镜像点电荷
q3 = -q2;%感应总电荷为0
x = linspace(-x0,x0,200);
y = linspace(-x0,x0,200);
[X,Y] = meshgrid(x,y);
b = ra^2/d;%镜像电荷的位置
r1 = sqrt((X - d).^2 + Y.^2); %点电荷到场点的距离
r2 = sqrt((X - b).^2 + Y.^2); %镜像电荷到场点的距离
r3 = sqrt(X.^2 + Y.^2); %镜像感应电荷到场点的距离
U = k*q1./r1 + k*q2./r2 + k*q3./r3;
U(sqrt(X.^2 + Y.^2) <= ra*0.9) = 0; %绘制出导体球
u0 = k*q1./ra + k*q2./ra + k*q3./ra; %基准电势，作为之后绘制等势线的参考尺度
u = linspace(-u0,u0,15);
c = contour(X,Y,U,u,'--');%绘制等势线
hold on;
[Ex, Ey] = gradient(-U);
Ne = 30; % 电力线的数量
th = linspace(0,2*pi,Ne);
x1 = d+0.002*cos(th);
y1 = 0.002*sin(th);
for i = 1:Ne
    h1 = streamline(X,Y,Ex,Ey,x1(i),y1(i));
    arrowPlot(h1.XData,h1.YData,'number',1,'color','b','linewidth',1);
    hold on;
end
hold on;
Ne2 = 15;
th2 = linspace(0,2*pi,Ne2);
x2 = ra*cos(th2);
y2 = ra*sin(th2);
for j = 1:Ne2
    h2 = streamline(X,Y,Ex,Ey,x2(j),y2(j));
    arrowPlot(h2.XData,h2.YData,'number',1,'color','r','linewidth',1);
    hold on;
end
theta = 0:pi/100:2*pi;
x = ra*cos(theta);
y = ra*sin(theta);
plot(x,y,'-');
axis equal %使x轴和y轴的单位长度相等，确保绘制的图形是一个圆
fill(x,y,'w')
xlabel('x','fontsize',16)
ylabel('y','fontsize',16)
title('点电荷位于不接地导体球外的电势分布及电力线','fontsize',16)   
%绘制球外电荷
plot(d,0,'ro',d,0,'r+','markersize',10,'linewidth',2);%‘r0’指红色的原点，‘r+’指红色的加号
plot(b,0,'bo','markersize',10,'linewidth',2);
text(0.0032,0.0004, '—', 'Color', 'b', 'FontSize', 13, 'FontWeight', 'bold');
plot(0,0,'go',0,0,'g+','markersize',10,'linewidth',2);
