% Fs = 32768;
% tVals = 0:(1/Fs):0.25;
% tau = 2*pi*tVals';
% fR = [697 770 852 941];
% trueR = [sin(tau*fR(1)) sin(tau*fR(2)) sin(tau*fR(3)) sin(tau*fR(4))];
% fC = [1209 1336 1477];
% trueC = [sin(tau*fC(1)) sin(tau*fC(2)) sin(tau*fC(3))];
% A = [trueR trueC];
% cosvals = zeros(7,7);
% for i =1:7
%     for j = 1:7
%         cosvals(i,j)=cos_xy(A(:,i),A(:,j));
%     end
% end
% cosvals
%%
clear
clc
keyboard = {1 2 3;
           4 5 6;
           7 8 9;
           '*' 0 '#'};
pos = {};
% % for trial =1:8
% %     close all
% %     i = ceil(rand(1)*4);
% %     j = ceil(rand(1)*3);
% %     [tVals,y]=MakeShowPlay(i,j);
% %     y=SendNoisy(tVals,y);  
n=1;
% [x,fs,bits]=wavread('C:\Users\think\Desktop\1.wav');
% x=reshape(x,size(x,1)*2,1); 
% cs=floor(size(x,1)/(fs/4+1));
% for trial=1:cs
% x=4*x;
%
        fs = 44100;
        x  = wavrecord(10*fs, fs, 'double');
        t=(0:length(x)-1)/fs;
        figure
        plot(t,10*x) %做原始语音信号的时域图形
        grid on
        pause
       %wavplay(x, fs);
%x=(x(:,1)+x(:,2))/2;
z=10*x;
trial=10
while (trial<=(length(x)-fs/4))
    if z(trial)>=4
        y=x(trial:(fs/4)+trial,1);
        [posi posj]=ShowCosines(y,fs);
        if posi==0||posj==0
            trial=trial+20;
        else
            pos{n}=keyboard{posi,posj};
            n=n+1;
            trial=trial+floor(fs/4);
        end
    else
        trial=trial+20;
    end
end
pos
