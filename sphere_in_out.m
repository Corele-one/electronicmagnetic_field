%%接地导体的内外球壳半径分别为a1=0.03，a2=0.034，q1位于球壳内，距离d1=0.01，q2位于球壳外，距离d2=0.05
%求导体球壳内外的电势电场分布
clc;
clear;
k = 8.99e9;
a1 = 0.03;
a2 = 0.034;
d1 = 0.01;%q1距离球心的距离
d2 = 0.05;%q2距离球心的距离
x0 = 0.08;
q1 = 1e-10;
q2 = 2e-10;
b2 = a2^2/d2;%在求球壳外部电场时，球体内的镜像电荷距离球心的位置
q2m = -a2/d2*q2;%球壳内部部的镜像电荷
b1 = a1^2/d1;%在求球壳内部电场时，球壳外部的镜像电荷距离球心的位置
q1m = -a1/d1*q1;%球壳内部的镜像电荷
x = linspace(-x0/2,x0,100);
y = linspace(-x0,x0,100);
[X,Y] = meshgrid(x,y);
%绘制球壳外电位和电场
r2 = sqrt((X-d2).^2 + Y.^2);
r2m = sqrt((X-b2).^2 + Y.^2);
U = k*q2./r2 + k*q2m./r2m;
U(sqrt(X^2+Y^2)<a2) = 0;%剔除球体
U2 = k*q2./0.01 + k*q2m./0.01;
u2 = linspace(-U2,U2,25);
c2 = contour(X,Y,U,u2,'--');
hold on;
[Ex2,Ey2] = gradient(-U);
N1 = 24;
th = linspace(0,2*pi,N1);
x2 = d2 + 0.002*cos(th);
y2 = 0.002*sin(th);
for i = 1:N1
    line1 = streamline(X,Y,Ex2,Ey2,x2(i),y2(i));
    arrowPlot(line1.XData,line1.YData,'number',1,'color','b','linewidth',1);
    hold on;
end

theta=0:pi/100:2*pi;
xa = a1*cos(theta);
ya = a1*sin(theta);
fill(xa,ya,'w');
hold on;
%绘制球壳内电位和电场
r1 = sqrt((X-d1).^2 + Y.^2);
r1m = sqrt((X-b1).^2 + Y.^2);
U1 = k*q1./r1 + k*q1m./r1m;
U1(sqrt(X.^2+Y.^2)>a1) = 0;%剔除球体
U11 = k*q1./0.01 + k*q1m./0.1;
u1 = linspace(-U11,U11,25);
c1 = contour(X,Y,U1,u1,'--');
hold on;
[Ex1,Ey1] = gradient(-U1);
N2 = 17;
th1 = linspace(0,2*pi,N2);
x1 = d1 + 0.002*cos(th1);
y1 = 0.002*sin(th1);
for j = 1:N2
    line2 = streamline(X,Y,Ex1,Ey1,x1(j),y1(j));
    arrowPlot(line2.XData,line2.YData,'number',1,'color','b','linewidth',1);
    hold on;
end
%绘制球壳
R = linspace(a1,a2,50);
c = linspace(0,2*pi,50);
for i = 1:50
    if ~ismember(i,[1,50])
        X1 = R(i)*cos(c);
        Y1 = R(i)*sin(c);
        plot(X1,Y1,'g','linewidth',1);
        hold on;
    else
        X1 = R(i)*cos(c);
        Y1 = R(i)*sin(c);
        plot(X1,Y1,'g-','linewidth',1);
        hold on;
    end
end


