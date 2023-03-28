% S5 Projet - TEAM Kirby
% Asservissements (Inclinaison plaque)
clc
close all
clear
clc

% Contrôle de l'affichage et FT
showGraphicsAndData = 1;
useLocalTransferFunction = 1;


% Fonction de transfert en entrée
if useLocalTransferFunction == 0
    FT_theta_phi = 0;% besoin de FT
else  
    numFT_theta_phi = [9744];
    denFT_theta_phi = [1 31.3 -1767 -55320];
    FT_theta_phi = tf(numFT_theta_phi,denFT_theta_phi);
end

% Spécifications
% ➢ dépassement maximum : 𝑀𝑃𝜃𝜑 = 5.0 %
% ➢ temps de stabilisation à 2% : 𝑡𝑠𝜃𝜑 = 0.030 s
% ➢ temps du premier pic: 𝑡𝑃𝜃𝜑 = 0.025 s
% ➢ temps de montée (10-90%) : 𝑡𝑟𝜃𝜑 = 0.020 s
% ➢ erreur en régime permanent à une consigne échelon : nulle

Mp_theta_phi = 5;           % En pourcent
ts2pc_theta_phi = 0.030;    % En secondes
tp_theta_phi = 0.025;       % En secondes
tr_10_90_theta_phi = 0.020; % En secondes

% Valeurs 
F=10;

% Spécifications dérivées
Phi_theta_phi = atand(-pi/log(Mp_theta_phi/100));
Zeta_theta_phi = cosd(Phi_theta_phi);
wn_ts2pc = 4./(ts2pc_theta_phi.*Zeta_theta_phi);
wn_tr_10_90 = (1 + 1.1.*Zeta_theta_phi +1.4.*(Zeta_theta_phi.^2))./tr_10_90_theta_phi;
wn_tp = pi/(tp_theta_phi.*sqrt(1-Zeta_theta_phi^2));
wn_theta_phi = wn_ts2pc;
wa_theta_phi = wn_theta_phi*sqrt(1-Zeta_theta_phi^2);
p_des_theta_phi = [((-wn_theta_phi*Zeta_theta_phi) + wa_theta_phi.*1i); ((-wn_theta_phi*Zeta_theta_phi) - wa_theta_phi.*1i)];
s_des_theta_phi = p_des_theta_phi(1);
if showGraphicsAndData == 1
    disp(['Φ = ', num2str(Phi_theta_phi)])
    disp(['ζ = ', num2str(Zeta_theta_phi)])
    disp(' ')
    disp(['ωn dérivé de ts(2%)     = ', num2str(wn_ts2pc), ' rad/s  <----'])
    disp(['ωn dérivé de tr(10-90%) = ', num2str(wn_tr_10_90), ' rad/s'])
    disp(['ωn dérivé de tp         = ', num2str(wn_tp), ' rad/s'])
    disp(' ')
    disp(['ωa dérivé de ωn         = ', num2str(wa_theta_phi), ' rad/s'])
    disp('Les pôles désirés sont à :')
    disp(num2str(p_des_theta_phi(1)))
    disp(num2str(p_des_theta_phi(2)))
    disp(' ')
end

[numFT_theta_phi,denFT_theta_phi] = tfdata(FT_theta_phi,'v');

Kpos_now_theta_phi = numFT_theta_phi(end)./denFT_theta_phi(end);
Kvel_des = 100;
Zpi = real(s_des_theta_phi)./F;
Ki_theta_phi = Kvel_des./Kpos_now_theta_phi;
Kp_theta_phi = Ki_theta_phi./Zpi;

numPI_theta_phi = [1 -Zpi];
denPI_theta_phi = [1 0];
PI_theta_phi = tf(Kp_theta_phi.*numPI_theta_phi,denPI_theta_phi);
FT_theta_phi_PI = PI_theta_phi*FT_theta_phi;


if showGraphicsAndData == 1
    disp('==========Compensateur PI==========')
    disp(' ')
    disp(['Kpos actuel = ', num2str(Kpos_now_theta_phi)])
    disp(['Kvel désiré = ', num2str(Kvel_des)])
    disp(['Ki desiré = ', num2str(Ki_theta_phi)])
    disp(['Kp désiré = ', num2str(Kp_theta_phi)])
    disp(' ')
    disp('La fonction de transfert du PI est : ')
    PI_theta_phi
    
    figure('Name','RootLocus FT theta et phi ainsi que leur PI')
    hold on
    rlocus(FT_theta_phi,'b')
    rlocus(FT_theta_phi_PI,'r')
    p_des_rl = rlocus(FT_theta_phi_PI,1);
    plot(real(p_des_theta_phi),imag(p_des_theta_phi),'p','MarkerEdgeColor','b')
    plot(real(p_des_rl),imag(p_des_rl),'s','MarkerEdgeColor','g')
    legend('FT','FT_PI','Pôles désirés','Pôles obtenus','Location','NorthWest')
    title('RootLocus FT \theta et \Phi et leur PI')
    hold off
end



