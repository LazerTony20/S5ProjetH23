clear all
close all
clc
load('Fe_attraction.mat');
load('Fs.mat');




%%  Identification de Fe avec la méthode des moindres carrées pour 1mA
be1 = 13.029359254409743;
Xnum_Fe_m1A = -(1+be1*abs(-1))
Xnum_Fe_2mA = -(4+be1*abs(-2))

%Méthode des moindres carrées
P = [ones(size(z_m1A)) z_m1A z_m1A.^2 z_m1A.^3 z_m1A.^4]./Xnum_Fe;
Y = 1./Fe_m1A;
A = pinv(P)*Y;

%Création de la fonction Fe
Fe_mc_1mA = Xnum_Fe_1mA./(A(1) + A(2).*z_m1A + A(3).*z_m1A.^2 + A(4).*z_m1A.^3)

%Calcul des erreurs RMS et corrélation E
E = sum((Fe_mc - Fe_m1A).^2);
N = size(Fe_mc);
N = N(1)
RMS = ((1/N)*E).^0.5;
Y_R2 = (1/N)*sum(Fe_m1A);
R_2 = sum((Fe_mc - Y_R2).^2)/sum((Fe_m1A-Y_R2).^2);

%Affichage sur graphique
figure();
hold on
plot(z_m1A, Fe_mc_1mA)
plot(z_m1A, Fe_m1A)

%Comparer avec valeur de Fe_m2A
Fe_mc_2mA = Xnum_Fe_2mA./(A(1) + A(2).*z_m2A + A(3).*z_m2A.^2 + A(4).*z_m2A.^3)

figure();
hold on
plot(z_m2A, Fe_mc_2mA)
plot(z_m2A, Fe_m2A)

E = sum((Fe_mc_2mA - Fe_m2A).^2);
N = size(Fe_mc_2mA);
N = N(1)
RMS = ((1/N)*E).^0.5;
Y_R2 = (1/N)*sum(Fe_m2A);
R_2 = sum((Fe_mc_2mA - Y_R2).^2)/sum((Fe_m2A-Y_R2).^2);

%%
clear all
load('Fe_attraction.mat');
load('Fs.mat');
Y = (Fs.^(-1));
z = z_pos
X = [ones(size(z)) z z.^2 z.^3].*-1;

R = X'*X;
P = X'*Y;
A = inv(R)*P;


Y_mc = -1.*(A(1) + A(2).*z + A(3).*z.^2 + A(4).*z.^3)

%Affichage de la fonction obtenue versus Y
figure() ;
hold on
plot(z, Y)
plot(z, Y_mc)

%Calcul des erreurs point à point et suppression des conditions
Fs_corrected = Fs;
z_corrected = z;
E_p = ((Y_mc-Y).^2).^0.5;


%Refaire la méthode des moindre carrée en enlevant les erreurs
clear all
load('Fe_attraction.mat');
load('Fs.mat');

Value_to_remove = 96;

Y = (Fs(1:end-Value_to_remove).^(-1));
z = z_pos(1:end-Value_to_remove)
X = [ones(size(z)) z z.^2 z.^3].*-1;

R = X'*X;
P = X'*Y;
A = inv(R)*P;
A_cor = A;

Fs_mc = -1./(A_cor(1) + A_cor(2).*z + A_cor(3).*z.^2 + A_cor(4).*z.^3)

figure() ;
hold on
plot(z, Fs(1:end-Value_to_remove))
plot(z, Fs_mc)
legend('Valeur pratique', 'Moindre carrée')

%Calcul des erreurs RMS et corrélation E
Fs = Fs(1:end-Value_to_remove);
E = sum((Fs_mc - Fs).^2);
N = size(Fs_mc);
N = N(1);
RMS = ((1/N)*E).^0.5;
Y_R2 = (1/N)*sum(Fs);
R_2 = sum((Fs_mc - Y_R2).^2)/sum((Fs-Y_R2).^2);



    
