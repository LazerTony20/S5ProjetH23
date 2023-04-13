clear all
clc
close all

load("donnees_prof_nl.mat")
Constante_NL


%% Validation simulation prof vs modèle simulink pour VA


V_simulated = timeseries(VA, tsim);
simout = sim('Courant','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.0001));

figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
plot(tsim, IA)
title('Courbe du courant du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2, 1, 2)
plot(simout.iCurrent.time,simout.iCurrent.data)
title('Courbe de la simulation du courant en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')

%% Validation simulation prof vs modèle simulink pour VA


V_simulated = timeseries(VB, tsim);
simout = sim('Courant','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.0001));

figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
plot(tsim, IB)
title('Courbe du courant du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2, 1, 2)
plot(simout.iCurrent.time,simout.iCurrent.data)
title('Courbe de la simulation du courant en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')

%% Validation simulation prof vs modèle simulink pour VC


V_simulated = timeseries(VC, tsim);
simout = sim('Courant','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.0001));

figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
plot(tsim, IC)
title('Courbe du courant du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2, 1, 2)
plot(simout.iCurrent.time,simout.iCurrent.data)
title('Courbe de la simulation du courant en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
