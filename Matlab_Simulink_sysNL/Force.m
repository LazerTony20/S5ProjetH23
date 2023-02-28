clc
close all
clear all

load("coefficients.mat")
load("donnees_prof_nl.mat")


%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

ae0 = A_fe(1);
ae1 = A_fe(2);
ae2 = A_fe(3);
ae3 = A_fe(4);

as0 = A_fs(1);
as1 = A_fs(2);
as2 = A_fs(3);
as3 = A_fs(4);
%%%%%%%%%%%%%%%%


poly_ae = [ae3 ae2 ae1 ae0];
poly_as = [as3 as2 as1 as0];
num = -1; %Numérateur de Fsk
be = 13.029359254409743; %Valeur de Be


%%
starttime = 0;
stoptime = 10;
fixedstep = 0.1;


%Valeur des entrées de la simulation
simulation_time = [starttime:fixedstep:stoptime];
i_simulated_values = ones(size(simulation_time))';
z_simulated_values = [starttime:fixedstep:simulation_time(end)]';


%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
z_simulated = timeseries(z_simulated_values, simulation_time);
i_simulated = timeseries(i_simulated_values, simulation_time);
simout = sim('Forces','StartTime',string(starttime),'StopTime',string(stoptime),'FixedStep',string(fixedstep));

%% Affichage
figure('Name','Force (Sim)')
plot(simout.F.time, simout.F.data)
title('Force over Time')
xlabel('Time')
ylabel('Force')
grid on


%% Simulation avec le prof


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
