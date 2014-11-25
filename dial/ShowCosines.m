function [posi posj]=ShowCosines(y,fs)
tVals = 0:(1/fs):0.25;
tau = 2*pi*tVals';
fR = [697 770 852 941];
trueR = [sin(tau*fR(1)) sin(tau*fR(2)) sin(tau*fR(3)) sin(tau*fR(4))];
fC = [1209 1336 1477];
trueC = [sin(tau*fC(1)) sin(tau*fC(2)) sin(tau*fC(3))];
for i =1:4
    rowcosine(i)=cos_xy(y,trueR(:,i));
end
for j=1:3
    colcosine(j)=cos_xy(y,trueC(:,j));
end
%subplot(1,2,1)
if max(rowcosine)>0.0191
    [numi posi]=max(rowcosine);
else
    posi=0;
end
%bar(rowcosine);
%subplot(1,2,2)
if max(colcosine)>0.0191
    [numj posj]=max(colcosine);
else
    posj=0;
end
%bar(colcosine);