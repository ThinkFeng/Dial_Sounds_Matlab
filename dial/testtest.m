clear;
%[xx,fs]=wavread('E:\mywhisper\shu.wav');
%[xx,fs]=wavread('E:\speech\x\w1xun_01.wav');
%[xx,fs]=wavread('E:\speech\耳语音切割\b\w1ba_5');
[xx,fs]=wavread('C:\Users\think\Desktop\1.wav');% 读取音频文件yuan.wav，并返回采样数据给变量xx及采样率Fs
[team,row]=size(xx);%将数组xx的行数赋给team,列数赋给row
if row==2
    x=(xx(:,1)+xx(:,2))/2;
    yy=x;
%如果语音信号xx为2列，即信号为双声道，则将其转换成单声道信号，即取两列的平均值赋给x，并将x的值赋给yy 
else
    x=xx;
    yy=x;
%若语音信号xx为单声道，则将xx的值赋给x，并将x的值赋给yy
end
x=x-mean(x)+0.1*rand(length(x),1);
N=length(x);%将语音信号长度赋给变量N
n=220;%对语音信号进行分帧，帧长为220
n1=160;%帧移为160
frame=floor((N-n)/(n-n1));%将分帧数赋给变量frame
%frame=floor(N/n);
for i=1:frame
    y1=x((i-1)*(n-n1)+1:(i-1)*(n-n1)+n).*hamming(n);
%对每段分帧进行加窗处理
    fy=fft(y1,n);
    nen(i,:)=abs(fy).^2;% 将频域信号功率赋给矩阵变量nen
    ang(i,:)=angle(fy);%将频域信号的相位角赋给矩阵变量ang
end

yuzhi=sum(sum(nen(2:5,:)))/(4*n);
for i=1:frame
    nen(i,:)=nen(i,:)-yuzhi;
    nen(i,find(nen(i,:)<0))=0;
    %chuli=nen(i,1:n/2);
    %chuli=chuli-yuzhi;
    %chuli(find(chuli<0))=0;
    %nen(i,:)=[chuli,fliplr(chuli)];    
    % nen(i,:)=filter(1,[0.5 0.5],nen(i,:));
   % nen(i,find(nen(i,:)<0))=0;
end
for i=1:frame
    nen(i,:)=sqrt(nen(i,:));%将纯语音功率谱开根，得到频域值
    jie=nen(i,:).*exp(j*ang(i,:));
    out(i,:)=real(ifft(jie))/hamming(n)'; %对纯语音频谱进行逆傅里叶变换，并取其实部，并进行去窗处理
 end
zong=out(:,1)';%将第一帧中未重叠部分记入数组zong
jiewei=n;
for i=2:(frame/(n-n1)-2)
zong(jiewei-n1+1:jiewei)=(zong(jiewei-n1+1:jiewei)+out(i,1)')/2;
jiewei=jiewei+n-n1;% 使指针jiewei依次指向下一帧的帧尾
zong=[zong;out(i,n1+1:end)'];%将从第二帧开始的每一帧中未重叠部分记入数组zong
end
%zong=out(1,:)';
%for i=2:frame
%zong=[zong;out(i,:)'];
%end
%
%for i=1:frame
 %   zong=[zong,nen(i,:)'];
  %  zong(i*(n-n1)+1:(i-1)*(n-n1)+n)
%=zong(i*(n-n1)+1:(i-1)*(n-n1)+n)/2;
figure(1); %创建图1
subplot(2,1,1); %把图形窗口分成2*1个小窗口，取第1个小窗口
plot(x);%以数组x绘图基本二维曲线
axis([1,(n-n1)*frame+n,min(x),max(x)]);% 对当前二维图形对象的X轴和Y轴进行标定，x轴的范围为1到最后一个分帧结尾，y轴的范围为带噪语音时域最小值到最大值
subplot(2,1,2); %把图形窗口分成2*1个小窗口，取第2个小窗口
specgram(x,fs,1024,n,n1);%画出语音的语谱图
figure(2); %创建图2
subplot(211); %把图形窗口分成2*1个小窗口，取第1个小窗口
plot(zong); %以数组zong绘图基本二维曲线
axis([1,(n-n1)*frame+n,min(zong),max(zong)]); % 对当前二维图形对象的X轴和Y轴进行标定，x轴的范围为1到最后一个分帧结尾，y轴的范围为纯语音时域最小值到最大值
subplot(212); %把图形窗口分成2*1个小窗口，取第2个小窗口
specgram(zong,fs,1024,n,n1); %画出语音的语谱图
wavplay(x,fs);%播放单声道带噪语音音频
wavplay(n,fs);%播放单声道纯净语音音频