clear all
close all
clc


load("donnees_prof_nl.mat")

%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises
g=9.81
rs = 0.0039;
ms = 0.008;
js = (2*ms*rs^2)/5

%%%%%%%%%%%%%%%%

%Paramètre de simulation
starttime = 0;
stoptime = 10;
fixedstep = 0.1;
%%

%Valeur des entrées de la simulation
simulation_time = [starttime:fixedstep:stoptime];
phi_simulated_values = ones(size(simulation_time))';
theta_simulated_values = ones(size(simulation_time))';


%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
phi_sim = timeseries(phi_simulated_values, simulation_time);
theta_sim = timeseries(theta_simulated_values, simulation_time);
simout = sim('sphere_position_model','StartTime',string(starttime),'StopTime',string(stoptime),'FixedStep',string(fixedstep));

%% Calcul avec formule théorique purement matlab
% ax = ((-ms*g)/(ms + (js/(rs^2))))*(cos(phi_simulated_values).^2).*sin(theta_simulated_values).*cos(theta_simulated_values);
ax = ((-ms*g)/(ms + (js/(rs^2)))).*theta_simulated_values;
vx = cumtrapz(simulation_time, ax); %Équivalent à l'intégrator
x = cumtrapz(simulation_time, vx); %Équivalent à l'integrator

% ay = ((ms*g)/(ms + js/rs^2))*(sin(phi_simulated_values)).*cos(phi_simulated_values).*cos(theta_simulated_values);
ay = ((ms*g)/(ms + js/rs^2)).*phi_simulated_values;
vy = cumtrapz(simulation_time, ay);
y = cumtrapz(simulation_time, vy);

%% Afficher la comparaison entre matlab/simulink
figure('Name','Position de la sphere (Matlab VS Simulink)');
hold on
plot(simout.xs.time, simout.xs.data);
plot(simout.ys.time, simout.ys.data);
plot(simulation_time, x,'y--')
plot(simulation_time, y,'c--')
title('Position de la sphere (Matlab VS Simulink)')
ylabel('Position')
xlabel('Time')
legend('Sim X','Sim Y','Matlab X','Matlab Y','Location','east')
hold off
grid on

%Erreur RMS
RMSE_x = ((1/101)*sum((simout.xs.data - x).^2))^0.5;
RMSE_y = ((1/101)*sum((simout.ys.data - y).^2))^0.5;

%% Comparaison avec le prof (matlab)

%Création des paramètres de la simulation 1. Ne doit pas être changé
%normalement.
phi_sim = timeseries(Ax, tsim);
theta_sim = timeseries(Ay, tsim);

%simout = sim('dynamic_plaque_model','StartTime',string(tsim(1)),'StopTime',string(tsim(end)),'FixedStep',string(0.001));

ax = ((-ms*g)/(ms + (js/(rs^2)))).*Ay;
vx = cumtrapz(tsim, ax); %Équivalent à l'intégrator
x = cumtrapz(tsim, vx); %Équivalent à l'integrator
ay = ((ms*g)/(ms + js/rs^2)).*Ax;
vy = cumtrapz(tsim, ay);
y = cumtrapz(tsim, vy);

figure('Name','Comparaison valeur simulation vs prof (matlab)')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Px)
title('Courbe de la position en X du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2, 1, 2)
hold on
plot(tsim, x)
title('Courbe de la position X en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')

figure('Name','Comparaison valeur simulation vs prof')
hold on
subplot(2, 1, 1)
hold on
plot(tsim, Py)
title('Courbe de la position Y du prof en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2, 1, 2)
hold on
plot(tsim, Py)
title('Courbe de la position Y en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')