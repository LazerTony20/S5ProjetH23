close all
clear all
clc

load("donnees_prof_nl.mat")
Constante_NL

phi_sim = timeseries(Ax, tsim);
theta_sim = timeseries(Ay, tsim);
z_sim = timeseries(Pz, tsim);



%%%%%%%%%%%%%%%%

simout = sim('Hauteur_Aimants_Plaque','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(0.0001));
simout2 = sim('Hauteur_Capteurs','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(0.0001));

%%%%%%%%%%%%%%%%




%% Test de la conversion de position (Version matlab)
z_a = Pz - XA.*Ay + YA.*Ax;
z_b = Pz - XB.*Ay + YB.*Ax;
z_c = Pz - XC.*Ay + YC.*Ax;
z_d = Pz - XD.*Ay + YD.*Ax;
z_e = Pz - XE.*Ay + YE.*Ax;
z_f = Pz - XF.*Ay + YF.*Ax;

figure('Name','Za')
hold on;
subplot(2,1,1)
plot(tsim, z_a)
subplot(2,1,2)
hold on;
plot(tsim, zA,'b')
plot(simout.ZA.time,simout.ZA.data,'--')
hold off

figure('Name','Zb')
hold on;
subplot(2,1,1)
plot(tsim, z_b)
subplot(2,1,2)
hold on
plot(tsim, zB,'b')
plot(simout.ZB.time,simout.ZB.data,'--')
hold off

figure('Name','Zc')
hold on;
subplot(2,1,1)
plot(tsim, z_c)
subplot(2,1,2)
hold on
plot(tsim, zC,'b')
plot(simout.ZC.time,simout.ZC.data,'--')
hold off

figure('Name','Zd')
subplot(2,1,1)
hold on
plot(tsim, z_d)
plot(simout2.ZD.time,simout2.ZD.data,'--')
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
plot(simout2.ZE.time,simout2.ZE.data,'--')
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
plot(simout2.ZF.time,simout2.ZF.data,'--')
legend('Matlab','Simulink')
hold off
subplot(2,1,2)
hold on
plot(tsim, zF)
legend('Prof')
hold off