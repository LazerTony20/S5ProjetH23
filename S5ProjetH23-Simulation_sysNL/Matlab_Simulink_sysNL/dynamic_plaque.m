clc
close all
clear 

load("donnees_prof_nl.mat")
Constante_NL


%% Comparaison avec le prof (simulink)

%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
F_a_sim = timeseries(FA, tsim);
F_b_sim = timeseries(FB, tsim);
F_c_sim = timeseries(FC, tsim);
X_sphere = timeseries(Px, tsim);
Y_sphere = timeseries(Py, tsim);

sim_step = 0.0001;

simout = sim('dynamic_plaque_model','StartTime',num2str(tsim(1)),'StopTime',num2str(tsim(end)), 'FixedStep',num2str(sim_step));

%% Comparaison avec le prof (matlab)
a_z = (FA + FB + FC + Fg)./mP;
v_z = cumtrapz(tsim, a_z); %Équivalent à l'intégrator
z = cumtrapz(tsim, v_z)+0.015; %Équivalent à l'integrator

a_phi = (FB.*YB + FC.*YC + Fg_sphere.*Py)./Jp;
w_phi = cumtrapz(tsim, a_phi); %Équivalent à l'intégrator
phi = cumtrapz(tsim, w_phi); %Équivalent à l'integrator

a_theta = -(FA.*XA + FB.*XB + FC.*XC + Fg_sphere.*Px)./Jp;
w_theta = cumtrapz(tsim, a_theta); %Équivalent à l'intégrator
theta = cumtrapz(tsim, w_theta); %Équivalent à l'integrator


%% Affichage Graphique de la position de la plaque Z
figure('Name','Comparaison valeur simulation vs prof (Simulink)')
hold on
plot(tsim, Pz)
plot(simout.z.time,simout.z.data)
plot(tsim,z,'--')
title('Courbe de la hauteur de la plaque en fonction du temps')
xlabel('temps [sec]')
ylabel('Hauteur ')
legend('prof','Simulation','Matlab')
hold off
grid on
 
%% Affichage graphique de l'angle phi en fonction du temps
figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
plot(tsim, Ay)
plot(simout.theta.time,simout.theta.data)
plot(tsim,theta,'--')
title('Angle \theta en fonction du temps')
xlabel('temps [sec]')
ylabel('\theta ')
legend('prof','simulation','Matlab')
hold off
grid on

%% Affichage graphique de l'angle theta en fonction du temps
figure('Name','Comparaison valeur simulation vs prof (Matlab)')
hold on
plot(tsim, Ax)
plot(simout.phi.time,simout.phi.data)
plot(tsim,phi,'--')
title('Angle \phi en fonction du temps')
xlabel('temps [sec]')
ylabel('\phi ')
legend('prof','Simulation','Matlab')
hold off
grid on

%% Afficher le graphique des coordonnées des actionneurs
figure('Name','Position des actionneur A B et C');
hold on
title('Position des actionneur A B et C')
plot(XA,YA, '.', 'MarkerSize',10)
plot(XB,YB, '.', 'MarkerSize',10)
plot(XC,YC, '.', 'MarkerSize',10)
xlim([-1.5, 1.5])
legend('A', 'B', 'C')
hold off
grid on
ylim([-0.1,0.1]);
yticks(-0.1:(0.01):0.1)
xlim([-0.1,0.1]);
xticks(-0.1:(0.01):0.1)
grid on

%% 
% figure('Name','Comparaison valeur simulation vs prof (Matlab)')
% hold on
% plot(tsim, Pz)
% plot(tsim,z)
% title('Courbe du courant en fonction du temps')
% xlabel('temps [sec]')
% ylabel('Hauteur ')
% legend('prof','simulation')
% grid on
% hold off
% 
