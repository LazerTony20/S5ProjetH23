close all
clear all
clc

load("donnees_prof_nl.mat")
%%%%%%%%%%%%%%%%

r_abc = 95.2*10^-3;
r_def = 80*10^-3;


phi_sim = timeseries(Ax, tsim);
theta_sim = timeseries(Ay, tsim);
z_sim = timeseries(Pz, tsim);

%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des forces. Pour le moment, des valeurs temporaires sont mises


Xa = r_abc;
Ya = 0;
Za = 0;
Xb = -r_abc*sin(deg2rad(30));
Yb = r_abc*cos(deg2rad(30));
Zb = 0;
Xc = -r_abc*sin(deg2rad(30));
Yc = -r_abc*cos(deg2rad(30));
Zc = 0;

Xd = r_def*sin(deg2rad(30));
Yd = r_def*cos(deg2rad(30));
% Xe = -r_def*sin(deg2rad(30));
Xe = -r_def;
Ye = 0;
Xf = r_def*sin(deg2rad(30));
Yf = -r_def*cos(deg2rad(30));



%%%%%%%%%%%%%%%%

simout = sim('Hauteur_Aimants_Plaque','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(0.0001));
simout2 = sim('Hauteur_Capteurs','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(0.0001));

%%%%%%%%%%%%%%%%


X_ai = Xa;
Y_ai = Ya;
X_bi = Xb;
Y_bi = Yb;
X_ci = Xc;
Y_ci = Yc;

%% Test de la conversion de position (Version matlab)
z_a = Pz - Xa.*Ay + Ya.*Ax;
z_b = Pz - Xb.*Ay + Yb.*Ax;
z_c = Pz - Xc.*Ay + Yc.*Ax;
z_d = Pz - Xd.*Ay + Yd.*Ax;
z_e = Pz - Xe.*Ay + Ye.*Ax;
z_f = Pz - Xf.*Ay + Yf.*Ax;

figure('Name','Za')
hold on;
subplot(2,1,1)
plot(tsim, z_a)
subplot(2,1,2)
hold on;
plot(tsim, zA,'b')
plot(simout.Z_a.time,simout.Z_a.data,'--')
hold off

figure('Name','Zb')
hold on;
subplot(2,1,1)
plot(tsim, z_b)
subplot(2,1,2)
hold on
plot(tsim, zB,'b')
plot(simout.Z_b.time,simout.Z_b.data,'--')
hold off

figure('Name','Zc')
hold on;
subplot(2,1,1)
plot(tsim, z_c)
subplot(2,1,2)
hold on
plot(tsim, zC,'b')
plot(simout.Z_c.time,simout.Z_c.data,'--')
hold off

figure('Name','Zd')
subplot(2,1,1)
hold on
plot(tsim, z_d)
plot(simout2.Z_d.time,simout2.Z_d.data,'--')
legend('Matlab','Simulink')
hold off
subplot(2,1,2)
hold on
plot(tsim, zD)
hold off

figure('Name','Ze')
subplot(2,1,1)
hold on;
plot(tsim, z_e)
plot(simout2.Z_e.time,simout2.Z_e.data,'--')
legend('Matlab','Simulink')
hold off
subplot(2,1,2)
hold on
plot(tsim, zE)
hold off

figure('Name','Zf')
subplot(2,1,1)
hold on;
plot(tsim, z_f)
plot(simout2.Z_f.time,simout2.Z_f.data,'--')
legend('Matlab','Simulink')
hold off
subplot(2,1,2)
hold on
plot(tsim, zF)
legend('Prof')
hold off