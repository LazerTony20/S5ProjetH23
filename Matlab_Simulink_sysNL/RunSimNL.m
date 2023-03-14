close all
clear all
clc

starttime = 0;
stoptime = 10;
fixedstep = 0.1;

bancEssaiConstantes;
load("coefficients.mat")
load("donnees_prof_nl.mat")

Xa = XA;
Xb = XB;
Xc = XC;
Xd = XD;
Xe = XE;
Xf = XF;

Ya = YA;
Yb = YB;
Yc = YC;
Yd = YD;
Ye = YE;
Yf = YF;

Va_sim = timeseries(VA,tsim);
Vb_sim = timeseries(VB,tsim);
Vc_sim = timeseries(VC,tsim);

mp = mP; 
ms = mS;
Jp = 1.347*10^-3;
Fg = mp*g;
Fg_sphere = ms*g;

be = 13.029359254409743; %Valeur de Be

ae0 = A_fe(1);
ae1 = A_fe(2);
ae2 = A_fe(3);
ae3 = A_fe(4);

as0 = A_fs(1);
as1 = A_fs(2);
as2 = A_fs(3);
as3 = A_fs(4);
%%%%%%%%%%%%%%%%


poly_ae = [ae3 ae2 ae1 ae0];
poly_as = [as3 as2 as1 as0];


simout = sim('Full_model','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));


figure('Name','Position x de la sphere')
hold on
plot(simout.pos_x_sphere.time,simout.pos_x_sphere.data)
grid on
hold off

figure('Name','Position Y de la sphere')
hold on
plot(simout.pos_y_sphere.time, simout.pos_y_sphere.data)
grid on
hold off





