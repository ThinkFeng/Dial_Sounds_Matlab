function [tVals,y] = MakeShowPlay(i,j)
%i,j�ֱ���������к���
fR = [697 770 852 941];%��Ӧ����1-4�е�Ƶ��
fC = [1209 1336 1477];%��Ӧ����1-3�е�Ƶ��
Fs = 1411000;%������
tVals = (0:(1/Fs):0.25)';%1/4��
yR = sin(2*pi*fR(i)*tVals);
yC = sin(2*pi*fC(j)*tVals);
y = (yR+yC)/2;
figure
set(gcf,'position',[100 550 800 160])
m = 300;
plot((1:m)',y(1:m),(1:m)',zeros(m,1),'-r');
%pause(1)
sound(y,Fs);
