%%点电荷位于接地导体球内
%半径为a=2cm的接地导体球内有一个点电荷q=1x10^(-10)C,点电荷距离球心d=0.7cm,求球内的电位与电场强度分布。
clear
k = 8.985e9;
ra = 0.02;
d = 0.007;
x0 = 0.025;
q1 = 1e-10;
q2 = -ra/d*q1;%q2为镜像点电荷
x2 = linspace(-x0,x0,60);
y2 = linspace(-x0,x0,60);
[X,Y] = meshgrid(x2,y2);
r1 = sqrt((X - d).^2 + Y.^2); %点电荷到场点的距离
r2 = sqrt((X - ra^2/d).^2 + Y.^2); %镜像电荷到场点的距离
U = k*q1./r1 + k*q2./r2;
U(sqrt(X.^2 + Y.^2) > ra) = 0; %研究区域为导体球内
theta = 0:pi/100:2*pi;
x1 = ra*cos(theta);
y1 = ra*sin(theta);
plot(x1,y1,'b','LineWidth',20);
hold on;
u0 = k*q1./0.01 + k*q2./0.1; %基准电势，作为之后绘制等势线的参考尺度
u = linspace(-u0,u0,30);
c = contour(X,Y,U,u,'--');
hold on;
[Ex,Ey] = gradient(-U);
N = 20;
th = linspace(0,2*pi,N);
x1 = d+0.001*cos(th);
y1 = 0.001*sin(th);
for i = 1:N
    h1 = streamline(X,Y,Ex,Ey,x1(i),y1(i));
    arrowPlot(h1.XData,h1.YData,'number',1,'color','b','linewidth',1);
    hold on;
end
%绘制接地符号
plot([-ra*1.02+0.0025,-ra*1.1],[-0.008,-0.008],'b','LineWidth',2)
plot([-ra*1.1,-ra*1.1],[-0.008,-0.012],'b','LineWidth',2);
plot([-ra*1.1-0.002,-ra*1.1+0.002],[-0.012,-0.012],'b','LineWidth',2);
hold on;
%绘制球内电荷
plot(d,0,'ko','markersize',16,'linewidth',3);
plot(d,0,'r+','markersize',12,'linewidth',3);
axis equal %使x轴和y轴的单位长度相等，确保绘制的图形是一个圆

