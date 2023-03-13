clear all
close all
clc

load("donnees_prof_nl.mat")
Constante_L
equation_lineaire

Force_lineaire = FA_L(1).*(Pz-Pzeq) + FA_L(2).*(IA-Ia_e) + FA(1);
figure();
hold on
plot(tsim, Force_lineaire)
plot(tsim, FA)
title('Comparaison de la Force entre la simulation linéaire et le non linéaire')
legend('Courbe de la force pour le linéaire', 'Courbe de la force pour le non linéaire')
grid on

figure();
hold on
subplot(2,1,1)
plot(tsim, Force_lineaire)
plot(tsim, FA)
title('Comparaison de la Force entre la simulation linéaire et le non linéaire')
legend('Courbe de la force pour le linéaire', 'Courbe de la force pour le non linéaire')
xlim([12 18])
grid on