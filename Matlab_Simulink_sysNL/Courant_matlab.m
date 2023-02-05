clear all
clc
close all

%Variable théorique du contexte
V = 10;
R = 3.6;
L = 0.115;
t = [0:0.001:0.2]; % Pour les calculs, t commence et fini dans les même temps que la simulation et les pas sont les même

i = (V/R).*((1-exp((-R/L).*t))); %Équation théorique du courrant dans un circuit Rl
current_sim = sim('Courant'); %Rouler la simulation. le nom de la simulation est le nom du fichier de simulink

figure()
hold on
subplot(2, 1, 1)
plot(t, i)
title('Courbe théorique du courant en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')
subplot(2,1, 2)
plot(current_sim.iCurrent.time,current_sim.iCurrent.data)
title('Courbe de la simulation du courant en fonction du temps')
xlabel('temps [sec]')
ylabel('courant [Amp]')


E = sum((current_sim.iCurrent.data- i').^2, 'all');
RMS = ((1/201)*E)^0.5;
disp(['Valeur RMS = ', num2str(RMS)])