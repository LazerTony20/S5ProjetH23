% S5 Projet - TEAM Kirby
% Asservissements (Sphere)
clc
close all
clear
clc

%THIS IS ONLY A ROUGH DRAFT OF THE CODE, NOT TO BE USED IN ANY FINAL
%PRODUCT

% xs & ys
num = [0 7.007];
den = [1 0 0];
G=tf(num,den);

zeta=0.9;
wn=4/(2*zeta);
wn2=4/(4*zeta);
phi=acosd(zeta);

s_des=-wn*zeta + 1j*wn*sqrt(1-zeta^2);
s_des2=-wn*zeta - 1j*wn*sqrt(1-zeta^2);

s_des_max=-wn2*zeta + 1j*wn2*sqrt(1-zeta^2);
s_des_max2=-wn2*zeta - 1j*wn2*sqrt(1-zeta^2);

kp=4.65;
kv=4;

Gv=tf([kv 0],1);

GGv=feedback(G,Gv);

Gtot=feedback(GGv*kp,1);


figure
hold on
rlocus(G,'b')
rlocus(GGv,'r')
rlocus(Gtot,'g')
plot([s_des s_des2],'hk')
plot([s_des_max s_des_max2],'hk')
grid on

figure
hold on
rlocus(GGv,'g')
plot([s_des s_des2],'hk')
plot([s_des_max s_des_max2],'hk')
grid on

T=[0:0.01:10];
u=ones(length(T),1);
Y=lsim(Gtot,u,T);

figure
hold on
% step(Gtot)
plot(T,Y)
plot([0 T(end)],[1 1],':')
%[Y,T] = step(Gtot);

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