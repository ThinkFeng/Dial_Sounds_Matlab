fs=44100; %语音信号采样频率为8000
x1=wavread('C:\Users\think\Desktop\2.wav');
t=(0:length(x1)-1)/44100;
y1=fft(x1,2048); %对信号做2048点FFT变换
f=fs*(0:1023)/2048;
figure(1)
plot(t,8*x1) %做原始语音信号的时域图形
grid on;axis tight;
title('原始语音信号');
xlabel('time(s)');
ylabel('幅度');
