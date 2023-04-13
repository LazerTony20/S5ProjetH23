close all
clear
clc
load('Fe_attraction.mat');
load('Fs.mat');


%%  Identification de Fe avec la méthode des moindres carrées pour 1mA

be1 = 13.029359254409743;
Xnum_Fe_m1A = -(1+be1*abs(-1))
Xnum_Fe_2mA = -(4+be1*abs(-2))

% Méthode des moindres carrées
X_Fe = [ones(size(z_m1A)) z_m1A z_m1A.^2 z_m1A.^3]./Xnum_Fe_m1A;
Y_Fe = 1./Fe_m1A;
R_Fe = X_Fe'*X_Fe;
P_Fe = X_Fe'*Y_Fe;
A_Fe = inv(R_Fe)*P_Fe;

% Création de la fonction Fe
Fe_mc_1mA = Xnum_Fe_m1A./(A_Fe(1) + A_Fe(2).*z_m1A + A_Fe(3).*z_m1A.^2 + A_Fe(4).*z_m1A.^3);

%%  Identification de Fe avec la méthode des moindres carrées pour 2mA
Fe_mc_2mA = Xnum_Fe_2mA./(A_Fe(1) + A_Fe(2).*z_m2A + A_Fe(3).*z_m2A.^2 + A_Fe(4).*z_m2A.^3);

%% Calcul des erreurs RMS et corrélation E
%Fe 1mA
E_RMS_Fe_1mA = sum((Fe_mc_1mA - Fe_m1A).^2)
N = size(Fe_mc_1mA);
N = N(1);
RMS_fe_1mA = ((1/N)*E_RMS_Fe_1mA).^0.5
Y_R2 = (1/N)*sum(Fe_m1A);
R_2_fe_1mA = sum((Fe_mc_1mA - Y_R2).^2)/sum((Fe_m1A-Y_R2).^2)

%Fe 2mA
E_RMS_Fe_2mA = sum((Fe_mc_2mA - Fe_m2A).^2)
N = size(Fe_mc_2mA);
N = N(1);
RMS_fe_2mA = ((1/N)*E_RMS_Fe_2mA).^0.5
Y_R2 = (1/N)*sum(Fe_m2A);
R_2_fe_2mA = sum((Fe_mc_2mA - Y_R2).^2)/sum((Fe_m2A-Y_R2).^2)

% %%
% Y = (Fs.^(-1));
% z = z_pos
% X = [ones(size(z)) z z.^2 z.^3].*-1;
% R = X'*X;
% P = X'*Y;
% A = inv(R)*P;
% 
% 
% Y_mc = -1.*(A(1) + A(2).*z + A(3).*z.^2 + A(4).*z.^3)
% 
% %Affichage de la fonction obtenue versus Y
% figure() ;
% hold on
% plot(z, Y)
% plot(z, Y_mc)
% 
% %Calcul des erreurs point à point et suppression des conditions
% Fs_corrected = Fs;
% z_corrected = z;
% E_p = ((Y_mc-Y).^2).^0.5;


%Refaire la méthode des moindre carrée en enlevant les erreurs
% clear all
% load('Fe_attraction.mat');
% load('Fs.mat');

%% Fs
Value_to_remove = 206;

Y_Fs = (Fs(1:end-Value_to_remove).^(-1));
z_Fs = z_pos(1:end-Value_to_remove);
X_Fs = [ones(size(z_Fs)) z_Fs z_Fs.^2 z_Fs.^3].*-1;

R_Fs = X_Fs'*X_Fs;
P_Fs = X_Fs'*Y_Fs;
A_Fs = inv(R_Fs)*P_Fs;
A_cor_Fs = A_Fs;

Fs_mc = -1./(A_cor_Fs(1) + A_cor_Fs(2).*z_Fs + A_cor_Fs(3).*z_Fs.^2 + A_cor_Fs(4).*z_Fs.^3);


%% Affichage sur graphique
% Affichage Fe MC 1mA
figure('Name','Fe Moindre Carre (1mA)');
hold on
title('Fe Moindre Carre (1mA)')
plot(z_m1A, Fe_m1A)
plot(z_m1A, Fe_mc_1mA)
legend('Valeur Originale','Moindre Carre','Location','SouthEast')
grid on
hold off

% Affichage Fe MC 2mA
figure('Name','Fe Moindre Carre (2mA)');
hold on
plot(z_m2A, Fe_m2A)
plot(z_m2A, Fe_mc_2mA)
legend('Valeur Originale','Moindre Carre','Location','SouthEast')
title('Fe Moindre Carre (2mA)')
grid on
hold off

% Affichage Fs MC
figure('Name','Fs Moindre carré') ;
hold on
plot(z_Fs, Fs(1:end-Value_to_remove))
plot(z_Fs, Fs_mc)
title('Fs Moindre carré')
legend('Valeur pratique', 'Moindre carrée','Location','SouthEast')
grid on
hold off
 
