clc
close all
clear all

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





%% Comparaison avec le prof (matlab)
a_z = (FA + FB + FC + Fg)/mp;
v_z = cumtrapz(tsim, a_z); %Équivalent à l'intégrator
z = cumtrapz(tsim, v_z)+0.015; %Équivalent à l'integrator

a_phi = -(FA.*XA + FB.*XB + FC*XC + Fg_s*Px)/Jp;
w_phi = cumtrapz(tsim, a_phi); %Équivalent à l'intégrator
phi = cumtrapz(tsim, w_phi); %Équivalent à l'integrator

a_theta = (FA.*YA + FB.*YB + FC*YC + Fg_s*Py)/Jp;
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

