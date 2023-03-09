clear all
close all
clc


load("donnees_prof_nl.mat")
Constante_NL


%% Comparaison avec le prof (matlab)

%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
phi_sim = timeseries(Ax, tsim);
theta_sim = timeseries(Ay, tsim);
simout = sim('sphere_position_model','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));


%% Affichage de la comparaison prof pour Xs
figure('Name','Comparaison valeur simulation vs prof (matlab)')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Px)
title('Courbe de la position en X du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('X [m]')
subplot(2, 1, 2)
hold on
plot(simout.Px.time, simout.Px.data)
title('Courbe de la position X en fonction du temps')
xlabel('temps [sec]')
ylabel('X [m]')

%% Comparaison avec prof pour Ys
figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Py)
title('Courbe de la position Y du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Y [m]')
subplot(2, 1, 2)
hold on
plot(simout.Py.time, simout.Py.data)
title('Courbe de la position Y en fonction du temps')
xlabel('temps [sec]')
ylabel('Y [m]')
%% Comparaison avec le prof (matlab)

%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
phi_sim = timeseries(Ax, tsim);
theta_sim = timeseries(Ay, tsim);

%simout = sim('dynamic_plaque_model','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));

ax = ((-masseS*g)/(masseS + (inertie_sphere/(rS^2)))).*Ay;
vx = cumtrapz(tsim, ax); %Équivalent à l'intégrator
x = cumtrapz(tsim, vx); %Équivalent à l'integrator
ay = ((masseS*g)/(masseS + inertie_sphere/rS^2)).*Ax;
vy = cumtrapz(tsim, ay);
y = cumtrapz(tsim, vy);

figure('Name','Comparaison valeur simulation vs prof (matlab)')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Px)
title('Courbe de la position en X du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('X [m]')
subplot(2, 1, 2)
hold on
plot(tsim, x)
title('Courbe de la position X en fonction du temps')
xlabel('temps [sec]')
ylabel('X [m]')

figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Py)
title('Courbe de la position Y du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Y [m]')
subplot(2, 1, 2)
hold on
plot(tsim, Py)
title('Courbe de la position Y en fonction du temps')
xlabel('temps [sec]')
ylabel('Y [m]')