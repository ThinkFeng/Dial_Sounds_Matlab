function [tVals,y] = MakeShowPlay(i,j)
%i,j分别代表按键的行和列
fR = [697 770 852 941];%对应键盘1-4行的频率
fC = [1209 1336 1477];%对应键盘1-3列的频率
Fs = 1411000;%采样率
tVals = (0:(1/Fs):0.25)';%1/4秒
yR = sin(2*pi*fR(i)*tVals);
yC = sin(2*pi*fC(j)*tVals);
y = (yR+yC)/2;
figure
set(gcf,'position',[100 550 800 160])
m = 300;
plot((1:m)',y(1:m),(1:m)',zeros(m,1),'-r');
%pause(1)
sound(y,Fs);
