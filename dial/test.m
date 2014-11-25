clear;
[w,fs,bits]=wavread('C:\Users\think\Desktop\2.wav');
v = w(:,2);%取出一个通道
k=length(v);
N=882;
n=ceil(k/N);
%分帧
a = enframe(v, N, N);%分帧 加汉明窗;
[n,z] = size(a);
zfft=zeros(n,N);
zifft=zeros(n,N);
for i=1:n;
    zfft=[i,(fft(a,i,N))];%fft转换
end

for i=1:n;
    zifft(i,1:N) = real(ifft(zfft(i,1:N),N));
end

[v,zo]=overlapadd(zifft);
%sound(v,fs,bits);
wavwrite(v,fs,bits,'C:\Users\think\Desktop\3.wav') ;