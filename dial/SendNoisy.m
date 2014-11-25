function yNoisy = SendNoisy(tVals,y)
clc
n = length(y);
A = .5;
yNoisy = y + A*randn(n,1);
m = 300;
plot((1:m)',yNoisy(1:m),(1:m)',zeros(m,1),'-r');
Fs = 32768;
%pause(1);
%sound(yNoisy,Fs)