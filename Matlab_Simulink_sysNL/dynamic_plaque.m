clc
close all
clear 

load("donnees_prof_nl.mat")
%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

g = 9.81;
mp = 425e-03 + 0.008; 
Jp = 1.347*10^-3;
Fg = mp*g;
r = 95.2*10^-3;

Xa = r;
Ya = 0;
Za = 0;
Xb = -r*sin(deg2rad(30));
Yb = r*cos(deg2rad(30));
Zb = 0;
Xc = -r*sin(deg2rad(30));
Yc = -r*cos(deg2rad(30));
Zc = 0;



Rs = 0.0039;
ms = 0.008;
Js = (2*ms*Rs^2)/5
Fg_s = ms*g
Fg_sphere = ms*g;

%%%%%%%%%%%%%%%%

starttime = 0;
stoptime = 10;
fixedstep = 0.1;

X_ai = Xa;
Y_ai = Ya;
X_bi = Xb;
Y_bi = Yb;
X_ci = Xc;
Y_ci = Yc;


%% Comparaison simulink/matlab préliminaire. C'est maintenant désuet et ne doit pas être utilisé
%Valeur des entrées de la simulation
% simulation_time = [starttime:fixedstep:stoptime];
% F_a_sim_values  = ones(size(simulation_time))'.*2;
% F_b_sim_values  = ones(size(simulation_time))'.*2;
% F_c_sim_values  = ones(size(simulation_time))'.*16;
% 
% 
% %Création des paramètres de la simulation 1. Ne doit pas être changé
% %normalement.
% F_a_sim = timeseries(F_a_sim_values, simulation_time);
% F_b_sim = timeseries(F_b_sim_values, simulation_time);
% F_c_sim = timeseries(F_c_sim_values, simulation_time);
% simout = sim('dynamic_plaque_model','StartTime',num2str(starttime),'StopTime',num2str(stoptime), 'FixedStep',num2str(fixedstep));
% 
% %Création des paramètres de la simulation 2 (Hauteur des aimants de la plaque. 
% % Ne doit pas être changé normalement.
% phi_sim     = timeseries(simout.phi.data, simulation_time);
% theta_sim   = timeseries(simout.theta.data, simulation_time);
% z_sim       = timeseries(simout.z.data, simulation_time);
% 
% simout2 = sim('Hauteur_Aimants_Plaque','StartTime',num2str(starttime),'StopTime',num2str(stoptime), 'FixedStep',num2str(fixedstep));
% Z_a_sim = simout2.Z_a.data;
% Z_b_sim = simout2.Z_b.data;
% Z_c_sim = simout2.Z_c.data;
% 
% %Évaluation (calcul) par matlab uniquement
% a_phi = (F_a_sim_values.*X_ai + F_b_sim_values.*X_bi + F_c_sim_values*X_ci)/mp;
% w_phi = cumtrapz(simulation_time, a_phi); %Équivalent à l'intégrator
% phi = cumtrapz(simulation_time, w_phi); %Équivalent à l'integrator
% 
% a_theta = (F_b_sim_values.*Y_bi +F_c_sim_values.*Y_ci)/mp;
% w_theta = cumtrapz(simulation_time, a_theta); %Équivalent à l'intégrator
% theta = cumtrapz(simulation_time, w_theta); %Équivalent à l'integrator
% 
% a_z = (FA + FB + FC + Fg)/mp;
% v_z = cumtrapz(simulation_time, a_z); %Équivalent à l'intégrator
% z = cumtrapz(simulation_time, v_z); %Équivalent à l'integrator
% 
% z_a = r.*theta + z;
% z_b = -((r./2).*theta) - ((r./2).*phi.*sqrt(3)) + z;
% z_c = ((r./2).*theta) - ((r./2).*phi.*sqrt(3)) + z;

%% Comparaison avec le prof (simulink)

%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
F_a_sim = timeseries(FA, tsim);
F_b_sim = timeseries(FB, tsim);
F_c_sim = timeseries(FC, tsim);
X_sphere = timeseries(Px, tsim);
Y_sphere = timeseries(Py, tsim);


simout = sim('dynamic_plaque_model','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(0.0001));

%% Affichage Graphique de la position de la plaque Z
figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
subplot(2, 1, 1)
plot(tsim, Pz)
title('Courbe de la hauteur de la plaque du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Hauteur ')
hold off
grid on
subplot(2, 1, 2)
plot(simout.z.time,simout.z.data)
title('Courbe de la hauteur de la plaque en fonction du temps')
xlabel('temps [sec]')
ylabel('hauteur ')
hold off
grid on
 
%% Affichage graphique de l'angle phi en fonction du temps
figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
subplot(2, 1, 1)
plot(tsim, Ay)
title('Angle \phi du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('\phi ')
hold off
grid on
subplot(2, 1, 2)
plot(simout.phi.time,simout.phi.data)
title('Angle \phi de la plaque en fonction du temps')
xlabel('temps [sec]')
ylabel('\phi ')
hold off
grid on


%% Affichage graphique de l'angle theta en fonction du temps
figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
subplot(2, 1, 1)
plot(tsim, Ax)
title('Angle \theta du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('\theta ')
hold off
grid on
subplot(2, 1, 2)
plot(simout.theta.time,simout.theta.data)
title('Angle \theta de la plaque en fonction du temps')
xlabel('temps [sec]')
ylabel('\theta ')
hold off
grid on


%% Afficher le graphique des coordonnées des actionneurs
figure('Name','Position des actionneur A B et C');
hold on
title('Position des actionneur A B et C')
plot(X_ai,Y_ai, '.', 'MarkerSize',10)
plot(X_bi,Y_bi, '.', 'MarkerSize',10)
plot(X_ci,Y_ci, '.', 'MarkerSize',10)
xlim([-1.5, 1.5])
legend('A', 'B', 'C')
hold off
grid on
ylim([-0.1,0.1]);
yticks(-0.1:(0.01):0.1)
xlim([-0.1,0.1]);
xticks(-0.1:(0.01):0.1)
grid on


%% Comparaison matlab/simulink (Désuet)
% figure('Name','Dynamique de la plaque (Matlab VS Simulink)');
% hold on
% title('\phi, \theta et z en fonction du temps')
% plot(simulation_time, simout.phi.data)
% plot(simulation_time, simout.theta.data)
% plot(simulation_time, simout.z.data)
% plot(simulation_time, phi,'r--')
% plot(simulation_time,theta,'--')
% plot(simulation_time, z,'b--')
% legend('Phi (Sim)', 'Theta (Sim)', 'Z (Sim)','Phi (Matlab)', 'Theta (Matlab)', 'Z (Matlab)','Location','northwest')
% hold off
% grid on

%% Comparaison matlab/simulink
figure('Name','Hauteur Aimants de la plaque (Matlab VS Simulink)');
hold on
title('Hauteur Aimants de la plaque')
plot(simulation_time, Z_a_sim)
plot(simulation_time, Z_b_sim)
plot(simulation_time, Z_c_sim)
plot(simulation_time, z_a,'r--')
plot(simulation_time, z_b,'--')
plot(simulation_time, z_c,'b--')
legend('Z_a (Sim)', 'Z_b (Sim)', 'Z_c (Sim)','Z_a (Matlab)', 'Z_b (Matlab)', 'Z_c (Matlab)','Location','northwest')
hold off
grid on


%% Comparaison avec le prof (matlab)
a_z = (FA + FB + FC + Fg)/mp;
v_z = cumtrapz(tsim, a_z); %Équivalent à l'intégrator
z = cumtrapz(tsim, v_z)+0.015; %Équivalent à l'integrator

a_phi = -(FA.*X_ai + FB.*X_bi + FC*X_ci + Fg_s*Px)/Jp;
w_phi = cumtrapz(tsim, a_phi); %Équivalent à l'intégrator
phi = cumtrapz(tsim, w_phi); %Équivalent à l'integrator

a_theta = (FA.*Y_ai + FB.*Y_bi + FC*Y_ci + Fg_s*Py)/Jp;
w_theta = cumtrapz(tsim, a_theta); %Équivalent à l'intégrator
theta = cumtrapz(tsim, w_theta); %Équivalent à l'integrator

figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
subplot(2, 1, 1)
plot(tsim, Pz)
title('Courbe du courant du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Hauteur ')
subplot(2, 1, 2)
plot(tsim,z)
title('Courbe de la hauteur de la plaque en fonction du temps')
xlabel('temps [sec]')
ylabel('hauteur ')

