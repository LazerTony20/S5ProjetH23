clear all
close all
clc

%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

ae0 = 4;
ae1 = 0.3;
ae2 = 0.02;
ae3 = 0.001;

as0 = 1;
as1 = 0.2;
as2 = 0.03;
as3 = 0.004;
%%%%%%%%%%%%%%%%


poly_ae = [ae3 ae2 ae1 ae0];
poly_as = [ae3 ae2 ae1 ae0];
num = -1; %Numérateur de Fsk
be = 5; %Valeur de Be. Donnée dans les spécifications (N'EST PAS LA BONNE EN CE MOMENT
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

plot(simout.Fek.time, simout.Fek.data)