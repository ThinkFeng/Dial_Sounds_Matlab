clear;
[w,fs,bits]=wavread('C:\Users\think\Desktop\2.wav');
v = w(:,2);%ȡ��һ��ͨ��
k=length(v);
N=882;
n=ceil(k/N);
%��֡
a = enframe(v, N, N);%��֡ �Ӻ�����;
[n,z] = size(a);
zfft=zeros(n,N);
zifft=zeros(n,N);
for i=1:n;
    zfft=[i,(fft(a,i,N))];%fftת��
end

for i=1:n;
    zifft(i,1:N) = real(ifft(zfft(i,1:N),N));
end

[v,zo]=overlapadd(zifft);
%sound(v,fs,bits);
wavwrite(v,fs,bits,'C:\Users\think\Desktop\3.wav') ;