% S5 Projet - TEAM Kirby
% Asservissements (Hauteur Plaque)
clc
close all
clear
clc

% Spécifications
% ➢ Marge de phase : 25 degrés
% ➢ Fréquence de traverse en gain : 185 rad/s
% ➢ Cas 1 : erreur en régime permanent à une consigne échelon : −0.0004 m pour une consigne de 0.010 m.
% ➢ Cas 2 : erreur en régime permanent à une consigne échelon : 0 m.

Pm_des = 25;
wg_des = 185;
erp_e1 = -0.04; % consigne de 1
erp_e2 = 0;

num = [30.31];
den = [1 31.3 -1213 -37970];
FTBO = tf(num,den);

figure
rlocus(FTBO)

% %----avph bode M1-----%
% 
% [mag,pha] = bode(FTBO,wg_des);
% Kdes = 1/mag;
% 
% FTBOtemp = tf(Kdes*num,den);
% 
% % 2. vérifier apres compensation
% 
% figure
% bode(FTBOtemp)
% hold on 
% margin(FTBOtemp)
% 
% [Gm,Pm,Wp,Wg] = margin(FTBOtemp);
% 
% % 3.
% mrg = 5;
% 
% delta_phi = (Pm_des - Pm + mrg); % + que 90 deg donc avph double
% 
% % calcul alpha
% alpha = (1 - sind(delta_phi))/(1 + sind(delta_phi));
% 
% T = 1/(wg_des*sqrt(alpha));
% 
% % 5.
% 
% zav = -1/T;
% 
% pav = -1/(alpha*T);
% 
% % 6.
% 
% Ka = Kdes/sqrt(alpha);
% 
% % 7.
% 
% numav = [1 -zav];
% denav = [1 -pav];
% 
% avph = tf(Ka*numav,denav);
% 
% FTBOav = FTBO*avph;
% 
% figure
% bode(FTBOav)
% hold on
% margin(FTBOav)
% 
% [Gmav,Pmav,Wpav,Wgav] = margin(FTBOav);

%-----avph bode M2----%


Kpos_des = (1/erp_e1)-1;

Kpos_act = num(end)/den(end);

K_des = Kpos_des/Kpos_act;

FTBOtemp = FTBO*K_des;

figure
margin(FTBOtemp)

[Gm,Pm,Wp,Wg] = margin(FTBOtemp);
mrg =25;

delta_phi = Pm_des - Pm + mrg;

alpha = (1 - sind(delta_phi/2))/(1 + sind(delta_phi/2));

T = 1/(wg_des*sqrt(alpha));

% 5.

zav = -1/T;

pav = -1/(alpha*T);

Ka = K_des/alpha;

numav = [1 -zav];
denav = [1 -pav];

avph = tf(numav,denav);

FTBOav = Ka*FTBO*avph^2;

figure
bode(FTBOav)
hold on
margin(FTBOav)

[Gmav,Pmav,Wpav,Wgav] = margin(FTBOav);





