clear all
close all
clc

%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

g = 9.81;
rs = 5;
js = 5;
ms = 0.01;
%%%%%%%%%%%%%%%%

%Paramètre de simulation
starttime = 0;
stoptime = 10;
fixedstep = 0.1;


%Valeur des entrées de la simulation
simulation_time = [starttime:fixedstep:stoptime];
phi_simulated_values = ones(size(simulation_time))';
theta_simulated_values = ones(size(simulation_time))';


%Création des paramètres de la simulation. Ne doit pas être changé
%normalement.
phi_sim = timeseries(phi_simulated_values, simulation_time);
theta_sim = timeseries(theta_simulated_values, simulation_time);
simout = sim('sphere_position_model','StartTime',string(starttime),'StopTime',string(stoptime),'FixedStep',string(fixedstep));

%Calcul avec formule théorique purement matlab
ax = ((-ms*g)/(ms + (js/(rs^2))))*(cos(phi_simulated_values).^2).*sin(theta_simulated_values).*cos(theta_simulated_values);
vx = cumtrapz(simulation_time, ax) %Équivalent à l'intégrator
x = cumtrapz(simulation_time, vx) %Équivalent à l'integrator
ay = ((ms*g)/(ms + js/rs^2))*(sin(phi_simulated_values)).*cos(phi_simulated_values).*cos(theta_simulated_values);
vy = cumtrapz(simulation_time, ay)
y = cumtrapz(simulation_time, vy)

%% Afficher la comparaison entre matlab/simulink
figure();
hold on
plot(simout.xs.time, simout.xs.data);
plot(simout.ys.time, simout.ys.data);
plot(simulation_time, y)
plot(simulation_time, x)

RMSE_x = ((1/101)*sum((simout.xs.data - x).^2))^0.5;
RMSE_y = ((1/101)*sum((simout.ys.data - y).^2))^0.5;