function pipi=drawEline(h1,d1,d2)
 
posAxes = get(gca, 'Position');  %获取当前坐标区位置信息
posX = posAxes(1);
posY = posAxes(2);
width = posAxes(3);
height = posAxes(4);%分解位置信息
hold on;
limX = get(gca, 'Xlim');%获取x轴范围
limY = get(gca, 'Ylim');%获取y轴范围
minX = limX(1);
maxX = limX(2);
minY = limY(1);
maxY = limY(2);
x=[h1(1).XData(d1) h1(1).XData(d2)];
y=[h1(1).YData(d1) h1(1).YData(d2)];
xNew = posX + (x - minX) / (maxX - minX) * width;
yNew = posY + (y - minY) / (maxY - minY) * height;%通过坐标变换得到箭头的绝对坐标
pipi=annotation('arrow', xNew, yNew);
