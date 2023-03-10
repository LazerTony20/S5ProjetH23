close all
clear all
clc

% Position à l'équilibre de la sphère (pour tests statiques)
sig = 1.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

%Point d'opération choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

%Exemple de trajectoire
t_des     = [0:1:8]'*5;
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;

%initialisation
bancEssaiConstantes
%bancessai_ini  %faites tous vos calculs de modele ici

%Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

equation_lineaire

%simulation
open_system('DYNctl_ver4_etud_obfusc')
set_param('DYNctl_ver4_etud_obfusc','AlgebraicLoopSolver','LineSearch')
sim('DYNctl_ver4_etud_obfusc')

save('Variable_etat_lineaire.mat', 'Vetats');
save('Sorties_ZDEF.mat', 'Vsorties');
%affichage
%trajectoires



%%
load('donnees_prof_nl.mat')
load('Variable_etat_lineaire.mat')
load('Sorties_ZDEF.mat')

Vetats_prof = [Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC];
Vsorties_prof = [zD zE zF];

data_to_show = 3;
figure();
subplot(2,1,1);
plot(Vetats.time, Vetats.data(:,data_to_show))
xlim([10,50])
subplot(2,1,2);
plot(tsim, Vetats_prof(:,data_to_show))
xlim([10,50])

data_to_show = 1;
figure();
subplot(2,1,1);
plot(Vsorties.time, Vsorties.data(:,data_to_show))
xlim([10,50])
subplot(2,1,2);
plot(tsim, Vsorties_prof(:,data_to_show))
xlim([10,50])