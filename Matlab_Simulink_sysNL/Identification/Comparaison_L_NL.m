close all
clear
clc

load("donnees_prof_nl.mat")
Constante_L
equation_lineaire

Force_lineaire = FA_L(1).*(Pz-Pzeq) + FA_L(2).*(IA-Ia_e) + FA(1);

%% Affichage
close all

figure('Name','Comparaison de la Force entre la simulation linéaire et le non linéaire');
hold on
plot(tsim, Force_lineaire)
plot(tsim, FA)
title('Comparaison de la Force entre la simulation linéaire et le non linéaire')
legend('Courbe de la force pour le linéaire', 'Courbe de la force pour le non linéaire')
grid on

figure('Name','Erreur entre le linéaire et le non-linéaire');
hold on
plot(tsim, Force_lineaire-FA)
title('Erreur entre le linéaire et le non-linéaire')
grid on

figure('Name','Courbe de la force version linéaire VS non-linéaire (Agrandi)');
hold on
subplot(2,1,1)
plot(tsim, Force_lineaire)
title('Courbe de la force version linéaire')
xlim([14.5 15.5])
grid on
subplot(2,1,2)
plot(tsim, FA)
title('Courbe de la force version non linéaire')
% legend('Courbe de la force pour le linéaire', 'Courbe de la force pour le non linéaire')
xlim([14.5 15.5])
grid on