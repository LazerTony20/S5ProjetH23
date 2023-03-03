clear all
clc
close all

load("donnees_prof_nl.mat")

R = 3.6;
L = 0.115;

%% Simulation général matlab vs simulink (Désuet)
%Variable théorique du contexte

% 
% starttime = 0;
% stoptime = 1;
% fixedstep = 0.00001;
% 
% 
% %Valeur des entrées de la simulation
% simulation_time = [starttime:fixedstep:stoptime]';
% V_simulated_values = zeros(size(simulation_time));
% V_simulated_values(simulation_time>0.2) = 5;
% V_simulated_values(simulation_time>0.7) = 0;
% 
% 
% % test = zeros(size(simulation_time));
% % test(simulation_time>0.2) = 5;
% % test(simulation_time>0.7) = 0;
% 
% i_tf = tf([1/R], [L/R 1])
% isim = lsim(i_tf,V_simulated_values,simulation_time)
% V_simulated = timeseries(V_simulated_values, simulation_time);
% simout = sim('Courant','StartTime',string(starttime),'StopTime',string(stoptime),'FixedStep',string(fixedstep));




%% Comparaison valeur simulation vs matlab (Désuet)
% 
% figure('Name','Comparaison valeur simulation vs matlab')
% hold on
% subplot(2, 1, 1)
% plot(simulation_time, isim)
% title('Courbe théorique du courant en fonction du temps')
% xlabel('temps [sec]')
% ylabel('courant [Amp]')
% subplot(2, 1, 2)
% plot(simout.iCurrent.time,simout.iCurrent.data)
% title('Courbe de la simulation du courant en fonction du temps')
% xlabel('temps [sec]')
% ylabel('courant [Amp]')
% 
% %Calcul de l'erreur
% E = sum((simout.iCurrent.data- isim).^2, 'all');
% length = size(simulation_time)
% RMS = ((1/length(1))*E)^0.5;
% disp(['Valeur RMS = ', num2str(RMS)])

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
