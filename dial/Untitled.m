fs=44100; %�����źŲ���Ƶ��Ϊ8000
x1=wavread('C:\Users\think\Desktop\2.wav');
t=(0:length(x1)-1)/44100;
y1=fft(x1,2048); %���ź���2048��FFT�任
f=fs*(0:1023)/2048;
figure(1)
plot(t,8*x1) %��ԭʼ�����źŵ�ʱ��ͼ��
grid on;axis tight;
title('ԭʼ�����ź�');
xlabel('time(s)');
ylabel('����');
