clear all

load("donnees_prof_nl.mat")
load("Sorties_zDEF.mat")
load("Variable_etat_lineaire.mat")
Constante_L
Valeur_Equilibre
equation_lineaire

%% Valider zD

delta_zD_theo_NL = (Pz-Pz_e) - XD.*(Ay-Ay_e) + YD.*(Ax-Ax_e);
delta_zD_BE_lin = (Vetats.data(:,3)-Pz_e) - XD.*(Vetats.data(:,2) - Ay_e) + YD.*(Vetats.data(:,1) - Ax_e);
zD_theo_lin = Pz_e + delta_zD_BE_lin;
zD_theo_NL = Pz_e + delta_zD_theo_NL;

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, zD_theo_lin)
plot(Vsorties.time, Vsorties.data(:,1))
title('Valeurs de Sortie zD de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on


subplot(2,1,2)
hold on
plot(tsim, zD_theo_NL)
plot(tsim, zD)
title('Valeurs de Sortie zD de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on


%% Valider zE

delta_zE_theo_NL = (Pz-Pz_e) - XE.*(Ay-Ay_e) + YE.*(Ax-Ax_e);
delta_zE_BE_lin = (Vetats.data(:,3)-Pz_e) - XE.*(Vetats.data(:,2) - Ay_e) + YE.*(Vetats.data(:,1) - Ax_e);
zE_theo_lin = Pz_e + delta_zE_BE_lin;
zE_theo_NL = Pz_e + delta_zE_theo_NL;

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, zE_theo_lin)
plot(Vsorties.time, Vsorties.data(:,2))
title('Valeurs de Sortie zE de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on


subplot(2,1,2)
hold on
plot(tsim, zE_theo_NL)
plot(tsim, zE)
title('Valeurs de Sortie zE de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on

%% Valider zF

delta_zF_theo_NL = (Pz-Pz_e) - XF.*(Ay-Ay_e) + YF.*(Ax-Ax_e);
delta_zF_BE_lin = (Vetats.data(:,3)-Pz_e) - XF.*(Vetats.data(:,2) - Ay_e) + YF.*(Vetats.data(:,1) - Ax_e);
zF_theo_lin = Pz_e + delta_zF_BE_lin;
zF_theo_NL = Pz_e + delta_zF_theo_NL;

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, zF_theo_lin)
plot(Vsorties.time, Vsorties.data(:,3))
title('Valeurs de Sortie zF de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on


subplot(2,1,2)
hold on
plot(tsim, zF_theo_NL)
plot(tsim, zF)
title('Valeurs de Sortie zF de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
ylim([0.01 0.02]);
yticks(0.01:0.002:0.02);
grid on

