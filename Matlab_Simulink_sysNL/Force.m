clc
close all
clear all

load("donnees_prof_nl.mat")
Constante_NL





% grid on


%% Simulation avec le prof pour Fa

%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
z_simulated = timeseries(zA, tsim);
i_simulated = timeseries(IA, tsim);
simout = sim('Forces','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));

figure('Name','Comparaison valeur simulation vs prof (Simulation)')
hold on
subplot(2, 1, 1)
plot(tsim, FA)
title('Courbe de Force du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')
subplot(2, 1, 2)
plot(simout.F.time,simout.F.data)
title('Courbe de la simulation de Force en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')

%% Simulation avec le prof pour Fb

%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
z_simulated = timeseries(zB, tsim);
i_simulated = timeseries(IB, tsim);
simout = sim('Forces','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));

figure('Name','Comparaison valeur simulation vs prof (Simulation)')
hold on
subplot(2, 1, 1)
plot(tsim, FB)
title('Courbe de Force du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')
subplot(2, 1, 2)
plot(simout.F.time,simout.F.data)
title('Courbe de la simulation de Force en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')

%% Simulation avec le prof pour Fc

%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
z_simulated = timeseries(zC, tsim);
i_simulated = timeseries(IC, tsim);
simout = sim('Forces','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));

figure('Name','Comparaison valeur simulation vs prof (Simulation)')
hold on
subplot(2, 1, 1)
plot(tsim, FC)
title('Courbe de Force du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')
subplot(2, 1, 2)
plot(simout.F.time,simout.F.data)
title('Courbe de la simulation de Force en fonction du temps')
xlabel('temps [sec]')
ylabel('Force [N]')
