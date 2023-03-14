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
load("coefficients.mat")

%Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%simulation
open_system('DYNctl_ver4_etud_obfusc')
set_param('DYNctl_ver4_etud_obfusc','AlgebraicLoopSolver','LineSearch')
sim('DYNctl_ver4_etud_obfusc')

%affichage
%trajectoires

%% Créer le fichier .mat
Ax = ynonlineaire(:,1);
Ay = ynonlineaire(:,2);
Pz = ynonlineaire(:,3);
Wx = ynonlineaire(:,4);
Wy = ynonlineaire(:,5);
Vz = ynonlineaire(:,6);
Px = ynonlineaire(:,7);
Py = ynonlineaire(:,8);
Vx = ynonlineaire(:,9);
Vy = ynonlineaire(:,10);
IA = ynonlineaire(:,11);
IB = ynonlineaire(:,12);
IC = ynonlineaire(:,13);
zA = ynonlineaire(:,14);
zB = ynonlineaire(:,15);
zC = ynonlineaire(:,16);
zD = ynonlineaire(:,17);
zE = ynonlineaire(:,18);
zF = ynonlineaire(:,19);
FA = ynonlineaire(:,20);
FB = ynonlineaire(:,21);
FC = ynonlineaire(:,22);
VA = ynonlineaire(:,23);
VB = ynonlineaire(:,24);
VC = ynonlineaire(:,25);

% save donnees_prof_nl.mat tsim Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC zA zB zC zD zE zF FA FB FC VA VB VC

