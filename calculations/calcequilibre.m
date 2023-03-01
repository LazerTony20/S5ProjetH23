clc;
close all;
clear all;
%% 

load('coefficients.mat');
g   = 9.81;
mP = 425e-03;     % kg
mS = 0.0080;           % kg
fg=(mP+mS)*g;
RR = 3.6;

z=0.015;
zk=[1 z^1 z^2 z^3];  %[z^3 z^2 z^1 1];
be1=13.029359254409743;

equfgleft=(-fg/3 + (1/(zk*A_fs)))*(zk*A_fe);

ineg=roots([1 -be1 equfgleft]);
ipos=roots([-1 -be1 equfgleft]);

i=[ineg;ipos];

sumF=3.*((i.*abs(i)+be1.*i)./(zk*A_fe)-(1/(zk*A_fs)))+fg;
ie=0;
for ijiji=[1:size(i)]
    if 0==sumF(ijiji)
        ie=i(ijiji)
    end
end

Ve=ie*RR


