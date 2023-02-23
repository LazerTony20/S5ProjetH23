clc
close all
clear all
%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

g = 9.81;
mp = 1;
Fg = mp*g;
r = 1;

Xa = -r;
Ya = 0;
Za = 1;

Xb = 0.5*r;
Yb = 0.5*r*(3)^0.5;
Zb = 1;

Xc = 0.5*r;
Yc = -0.5*r*(3)^0.5;
Zc = 1;

js = 5;
ms = 0.01;

%%%%%%%%%%%%%%%%

starttime = 0;
stoptime = 10;
fixedstep = 0.1;

%Valeur des entrées de la simulation
simulation_time = [starttime:fixedstep:stoptime];
F_a_sim_values  = ones(size(simulation_time))'.*2;
F_b_sim_values  = ones(size(simulation_time))'.*2;
F_c_sim_values  = ones(size(simulation_time))'.*16;


%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
F_a_sim = timeseries(F_a_sim_values, simulation_time);
F_b_sim = timeseries(F_b_sim_values, simulation_time);
F_c_sim = timeseries(F_c_sim_values, simulation_time);
simout = sim('dynamic_plaque_model','StartTime',num2str(starttime),'StopTime',num2str(stoptime), 'FixedStep',num2str(fixedstep));

%Création des paramètres de la simulation 2 (Hauteur des aimants de la plaque. 
% Ne doit pas être changé normalement.
phi_sim     = timeseries(simout.phi.data, simulation_time);
theta_sim   = timeseries(simout.theta.data, simulation_time);
z_sim       = timeseries(simout.z.data, simulation_time);

simout2 = sim('Hauteur_Aimants_Plaque','StartTime',num2str(starttime),'StopTime',num2str(stoptime), 'FixedStep',num2str(fixedstep));
Z_a_sim = simout2.Z_a.data;
Z_b_sim = simout2.Z_b.data;
Z_c_sim = simout2.Z_c.data;

%Évaluation (calcul) par matlab uniquement
a_phi = (-Xa.*F_a_sim_values - Xb.*F_b_sim_values - Xc.*F_c_sim_values)/mp;
w_phi = cumtrapz(simulation_time, a_phi); %Équivalent à l'intégrator
phi = cumtrapz(simulation_time, w_phi); %Équivalent à l'integrator

a_theta = (-Ya.*F_a_sim_values - Yb.*F_b_sim_values - Yc.*F_c_sim_values)/mp;
w_theta = cumtrapz(simulation_time, a_theta); %Équivalent à l'intégrator
theta = cumtrapz(simulation_time, w_theta); %Équivalent à l'integrator

a_z = (-Za.*F_a_sim_values - Zb.*F_b_sim_values - Zc.*F_c_sim_values + Fg)/mp;
v_z = cumtrapz(simulation_time, a_z); %Équivalent à l'intégrator
z = cumtrapz(simulation_time, v_z); %Équivalent à l'integrator

z_a = r.*theta + z;
z_b = -((r./2).*theta) - ((r./2).*phi.*sqrt(3)) + z;
z_c = ((r./2).*theta) - ((r./2).*phi.*sqrt(3)) + z;

%% Afficher le graphique des coordonnées des actionneurs
figure('Name','Position des actionneur A B et C');
hold on
title('Position des actionneur A B et C')
plot(Xa,Ya, '.')
plot(Xb,Yb, '.')
plot(Xc,Yc, '.')
xlim([-1.5, 1.5])
legend('A', 'B', 'C')
hold off
grid on

%% Afficher les résultats de la simulation
figure('Name','\phi, \theta et z en fonction du temps');
hold on
title('phi, theta et z en fonction du temps (Sim)')
plot(simulation_time, simout.phi.data,'b')
plot(simulation_time, simout.theta.data,'y--')
plot(simulation_time, simout.z.data)
legend('Phi', 'Theta', 'Z')
hold off
grid on

%% Comparaison matlab/simulink
figure('Name','Dynamique de la plaque (Matlab VS Simulink)');
hold on
title('\phi, \theta et z en fonction du temps')
plot(simulation_time, simout.phi.data)
plot(simulation_time, simout.theta.data)
plot(simulation_time, simout.z.data)
plot(simulation_time, phi,'r--')
plot(simulation_time,theta,'--')
plot(simulation_time, z,'b--')
legend('Phi (Sim)', 'Theta (Sim)', 'Z (Sim)','Phi (Matlab)', 'Theta (Matlab)', 'Z (Matlab)','Location','northwest')
hold off
grid on

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

%% Erreur RMS
RMSE_phi = ((1/101)*sum((simout.phi.data - phi).^2))^0.5;
RMSE_zeta = ((1/101)*sum(( simout.theta.data - theta).^2))^0.5;
RMSE_z = ((1/101)*sum((simout.z.data - z).^2))^0.5;
