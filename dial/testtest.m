clear;
%[xx,fs]=wavread('E:\mywhisper\shu.wav');
%[xx,fs]=wavread('E:\speech\x\w1xun_01.wav');
%[xx,fs]=wavread('E:\speech\�������и�\b\w1ba_5');
[xx,fs]=wavread('C:\Users\think\Desktop\1.wav');% ��ȡ��Ƶ�ļ�yuan.wav�������ز������ݸ�����xx��������Fs
[team,row]=size(xx);%������xx����������team,��������row
if row==2
    x=(xx(:,1)+xx(:,2))/2;
    yy=x;
%��������ź�xxΪ2�У����ź�Ϊ˫����������ת���ɵ������źţ���ȡ���е�ƽ��ֵ����x������x��ֵ����yy 
else
    x=xx;
    yy=x;
%�������ź�xxΪ����������xx��ֵ����x������x��ֵ����yy
end
x=x-mean(x)+0.1*rand(length(x),1);
N=length(x);%�������źų��ȸ�������N
n=220;%�������źŽ��з�֡��֡��Ϊ220
n1=160;%֡��Ϊ160
frame=floor((N-n)/(n-n1));%����֡����������frame
%frame=floor(N/n);
for i=1:frame
    y1=x((i-1)*(n-n1)+1:(i-1)*(n-n1)+n).*hamming(n);
%��ÿ�η�֡���мӴ�����
    fy=fft(y1,n);
    nen(i,:)=abs(fy).^2;% ��Ƶ���źŹ��ʸ����������nen
    ang(i,:)=angle(fy);%��Ƶ���źŵ���λ�Ǹ����������ang
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
    nen(i,:)=sqrt(nen(i,:));%�������������׿������õ�Ƶ��ֵ
    jie=nen(i,:).*exp(j*ang(i,:));
    out(i,:)=real(ifft(jie))/hamming(n)'; %�Դ�����Ƶ�׽����渵��Ҷ�任����ȡ��ʵ����������ȥ������
 end
zong=out(:,1)';%����һ֡��δ�ص����ּ�������zong
jiewei=n;
for i=2:(frame/(n-n1)-2)
zong(jiewei-n1+1:jiewei)=(zong(jiewei-n1+1:jiewei)+out(i,1)')/2;
jiewei=jiewei+n-n1;% ʹָ��jiewei����ָ����һ֡��֡β
zong=[zong;out(i,n1+1:end)'];%���ӵڶ�֡��ʼ��ÿһ֡��δ�ص����ּ�������zong
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
figure(1); %����ͼ1
subplot(2,1,1); %��ͼ�δ��ڷֳ�2*1��С���ڣ�ȡ��1��С����
plot(x);%������x��ͼ������ά����
axis([1,(n-n1)*frame+n,min(x),max(x)]);% �Ե�ǰ��άͼ�ζ����X���Y����б궨��x��ķ�ΧΪ1�����һ����֡��β��y��ķ�ΧΪ��������ʱ����Сֵ�����ֵ
subplot(2,1,2); %��ͼ�δ��ڷֳ�2*1��С���ڣ�ȡ��2��С����
specgram(x,fs,1024,n,n1);%��������������ͼ
figure(2); %����ͼ2
subplot(211); %��ͼ�δ��ڷֳ�2*1��С���ڣ�ȡ��1��С����
plot(zong); %������zong��ͼ������ά����
axis([1,(n-n1)*frame+n,min(zong),max(zong)]); % �Ե�ǰ��άͼ�ζ����X���Y����б궨��x��ķ�ΧΪ1�����һ����֡��β��y��ķ�ΧΪ������ʱ����Сֵ�����ֵ
subplot(212); %��ͼ�δ��ڷֳ�2*1��С���ڣ�ȡ��2��С����
specgram(zong,fs,1024,n,n1); %��������������ͼ
wavplay(x,fs);%���ŵ���������������Ƶ
wavplay(n,fs);%���ŵ���������������Ƶ