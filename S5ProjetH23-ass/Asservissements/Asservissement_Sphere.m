
close all
clear all 
clc
format short g


num=[7.007];
den=[1 0 0];
G = assphere(num,den);
Gtot=feedback(G,1);

figure
hold on
rlocus(Gtot,'b')
grid on

figure
hold on
step(Gtot)

T=[0:0.01:10];
u=ones(length(T),1);
Y=lsim(Gtot,u,T);



Mp=100*(max(Y)-1);
Mpdes=100*exp(-pi/tand(acosd(0.9)));
Mpdiff=abs(Mp-Mpdes);

if (0.01<Mpdiff)
     Mp
end

ind=find((Y<0.98)|(Y>1.02),1,'last');

ts=T(ind);

if (ts<2)||(ts>4)
    ts
end


figure
hold on
nyquist(G,'b')
grid on


testdiscret(Gtot)



