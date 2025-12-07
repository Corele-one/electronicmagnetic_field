%无限长线电荷位于介质中的电场
%假设无限长线电荷位于介质1中,介质1的介电常数为er1=3,介质2的介电常数为er2=8,线电荷线密度为lambda_1=1.6x10^(-19)C/m,
%试求无限长线电荷对在介质中的镜像线电荷的电场强度分布。
clear
clc
r0 = 14; %计算区域
h = 30; %线电荷距原点距离
e0 = 8.85e-12; %真空介电常数
er1 = 3; %介质相对介电常数
er2 = 8; %介质相对介电常数
lambda_1 = 1.6e-19; %线电荷线密度

n = e0*er1 + e0*er2; 
lambda_2 = ((e0*er1 - e0*er2)/n)*lambda_1; %计算介质1的场时，在介质2中的镜像线电荷线密度
lambda_3 = (2*e0*er2/n)*lambda_1; %计算介质2的场时，在介质1中的镜像线电荷线密度
%下半部分的等效单位线电荷
r = 140; %最大电势点的半径
rf = 1000;%设定电势0点
u0 = lambda_1 * log(rf/r) / (2 * pi * e0 * 6); % 算出最小的电势
u = linspace(1, 2, 6) * u0; % 求出各条等势线的电势大小

Np = 100; % 将 X 坐标分成 100 等份
x = linspace(-r, r, Np); % 在直角坐标中形成网格坐标
[X, Y] = meshgrid(x);
U = zeros(Np); % 初始化 U

r1 = sqrt(X.^2 + (Y - h).^2);
r2 = sqrt(X.^2 + (Y + h).^2);
r3 = sqrt(X.^2 + (Y - h).^2);

m1 = 2 * pi * e0 * er1; % 介质 1 中 2 * pi * 介电常数
m2 = 2 * pi * e0 * er2; % 介质 1 中 2 * pi * 介电常数

%% 空间充满介质2时的电势和电场计算
for i = 1:Np      % 给电势赋值
    for j = 1:Np
        U(i,j) = lambda_3 * log(rf/r3(i,j))/m2;
    end
end

division = plot([-r, r], [0, 0], 'k', 'LineWidth', 2); % 介质分界面
contour(X, Y, U, u, 'b--','linewidth',1.5); % 绘制等势线
hold on;
[Ex, Ey] = gradient(-U); % 计算电场分量
E = sqrt(Ex.^2 + Ey.^2); % 计算电场强度大小

% 步骤三：绘制电力线
Ne = 21; % 电力线条数
t = linspace(0, 2*pi, Ne); % 确定电场线角度步进
rd = 4; % 电场线起点半径
start_x1 = rd * cos(t); % 电场线起点 x 坐标
start_y1 = h + rd * sin(t); % 电场线起点 y
for i = 1:Ne
    he = streamline(X, Y, Ex, Ey, start_x1(i), start_y1(i)); % 计算电场线
    hold on
    arrowPlot(he.XData, he.YData, 'number', 1, 'color', 'b', 'LineWidth', 2); % 绘制带箭头电场线
    hold on
end

axis equal
hold on
plot(0,h,'ro',0,h,'r+','MarkerSize',12,'LineWidth',2);
