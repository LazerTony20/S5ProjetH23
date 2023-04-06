% S5 Projet - TEAM Kirby
% Asservissements (Inclinaison plaque)
clc
close all
clear
clc

% Contrôle de l'affichage et FT
showGraphicsAndData = 1;            % Variable pour l'affichage des figures et infos dans le terminal
showIntermediaryGraphs = 1;         % Variable pour montrer les graphiques des fonctions intermédiaires
useLocalTransferFunction = 1;       % Variable pour l'utilisation de la FT hard-codée (et non une externe)
useLocalResponseSimulation = 1;     % Variable pour l'exécution de la simulation
useFineTuning = 0;                  % Variable pour l'utilisation de Fine Tuning

% Fonction de transfert en entrée
if useLocalTransferFunction == 0
    FT_Inc_Plaque = 0;% Utilisation d'une FT Externe
else  
    numFT_Inc_Plaque = [9744];
    denFT_Inc_Plaque = [1 31.3 -1767 -55320];
    FT_Inc_Plaque = tf(numFT_Inc_Plaque,denFT_Inc_Plaque);
end

% Spécifications
% ➢ dépassement maximum : 𝑀𝑃𝜃𝜑 = 5.0 %
% ➢ temps de stabilisation à 2% : 𝑡𝑠𝜃𝜑 = 0.030 s
% ➢ temps du premier pic: 𝑡𝑃𝜃𝜑 = 0.025 s
% ➢ temps de montée (10-90%) : 𝑡𝑟𝜃𝜑 = 0.020 s
% ➢ erreur en régime permanent à une consigne échelon : nulle

Mp_Inc_Plaque = 5;           % En pourcent
ts2pc_Inc_Plaque = 0.030;    % En secondes
tp_Inc_Plaque = 0.025;       % En secondes
tr_10_90_Inc_Plaque = 0.020; % En secondes

% Valeurs 
F_Inc_Plaque = 10;


% Fine Tuning Variables
if useFineTuning == 1
    % Modificaiton des pôles pour tirer vers la gauche
    P_deplacement_real = -400;  %(-97,0);%(-65,1);
    P_deplacement_imag = 350 * 1i;
    % Surcompensation DeltaPhi
    DeltaPhi_surcomp_AvPh = 72;
    % Facteur de Gain de l'avance de phase
    Fac_Gain_AvPh = 0.97;    
end

% Spécifications dérivées
Phi_Inc_Plaque = atand(-pi/log(Mp_Inc_Plaque/100));
Zeta_Inc_Plaque = cosd(Phi_Inc_Plaque);
wn_ts2pc_Inc_Plaque = 4./(ts2pc_Inc_Plaque.*Zeta_Inc_Plaque);
wn_tr_10_90_Inc_Plaque = (1 + 1.1.*Zeta_Inc_Plaque +1.4.*(Zeta_Inc_Plaque.^2))./tr_10_90_Inc_Plaque;
wn_tp_Inc_Plaque = pi/(tp_Inc_Plaque.*sqrt(1-Zeta_Inc_Plaque^2));
wn_Inc_Plaque = wn_ts2pc_Inc_Plaque;
wa_Inc_Plaque = wn_Inc_Plaque*sqrt(1-Zeta_Inc_Plaque^2);
p_des_Inc_Plaque = [((-wn_Inc_Plaque*Zeta_Inc_Plaque) + wa_Inc_Plaque.*1i); ((-wn_Inc_Plaque*Zeta_Inc_Plaque) - wa_Inc_Plaque.*1i)];

if useFineTuning == 1
    % Modificaiton des pôles pour tirer vers la gauche
    p_des_Inc_Plaque(1) = p_des_Inc_Plaque(1) + P_deplacement_real + P_deplacement_imag;
    p_des_Inc_Plaque(2) = p_des_Inc_Plaque(2) + P_deplacement_real - P_deplacement_imag;
end

s_des_Inc_Plaque = p_des_Inc_Plaque(1);
% Affichage des spécifications dérivées
if showGraphicsAndData == 1
    disp(['Φ = ', num2str(Phi_Inc_Plaque)])
    disp(['ζ = ', num2str(Zeta_Inc_Plaque)])
    disp(' ')
    disp(['ωn dérivé de ts(2%)     = ', num2str(wn_ts2pc_Inc_Plaque), ' rad/s  <----'])
    disp(['ωn dérivé de tr(10-90%) = ', num2str(wn_tr_10_90_Inc_Plaque), ' rad/s'])
    disp(['ωn dérivé de tp         = ', num2str(wn_tp_Inc_Plaque), ' rad/s'])
    disp(' ')
    disp(['ωa dérivé de ωn         = ', num2str(wa_Inc_Plaque), ' rad/s'])
    disp('Les pôles désirés sont à :')
    disp(num2str(p_des_Inc_Plaque(1)))
    disp(num2str(p_des_Inc_Plaque(2)))
    disp(' ')
end

[numFT_Inc_Plaque,denFT_Inc_Plaque] = tfdata(FT_Inc_Plaque,'v');

% ===============Compensateur Multiple AvPh===============
nb_AvPh = 4;
Alpha_Inc_Plaque = 180 - Phi_Inc_Plaque;
Angle_FT_Inc_Plaque = rad2deg(angle(polyval(numFT_Inc_Plaque,s_des_Inc_Plaque))-angle(polyval(denFT_Inc_Plaque,s_des_Inc_Plaque)))-360;
DeltaPhi_Inc_Plaque = -180 - Angle_FT_Inc_Plaque;
DeltaPhi_Inc_Plaque = DeltaPhi_Inc_Plaque + 5;                         % Ajout de ma marge
if useFineTuning == 1
    DeltaPhi_Inc_Plaque = DeltaPhi_Inc_Plaque + DeltaPhi_surcomp_AvPh;     % Surcompensation
end
Phi_Z_Inc_Plaque = (Alpha_Inc_Plaque + DeltaPhi_Inc_Plaque./nb_AvPh)./2;
Phi_P_Inc_Plaque = (Alpha_Inc_Plaque - DeltaPhi_Inc_Plaque./nb_AvPh)./2;
Za_pos_Inc_Plaque = real(s_des_Inc_Plaque) - (imag(s_des_Inc_Plaque)./tand(Phi_Z_Inc_Plaque));
Pa_pos_Inc_Plaque = real(s_des_Inc_Plaque) - (imag(s_des_Inc_Plaque)./tand(Phi_P_Inc_Plaque));
Ka_AvPh_Inc_Plaque = 1./abs((((s_des_Inc_Plaque - Za_pos_Inc_Plaque).^nb_AvPh)./((s_des_Inc_Plaque - Pa_pos_Inc_Plaque)).^nb_AvPh).*(polyval(numFT_Inc_Plaque,s_des_Inc_Plaque)./polyval(denFT_Inc_Plaque,s_des_Inc_Plaque)));

if useFineTuning == 1
    Ka_AvPh_Inc_Plaque = Ka_AvPh_Inc_Plaque*Fac_Gain_AvPh;     % Facteur de Gain
end

AvPh_Temp_Inc_Plaque=tf([1 -Za_pos_Inc_Plaque],[1 -Pa_pos_Inc_Plaque]);
AvPh_Inc_Plaque = (AvPh_Temp_Inc_Plaque^nb_AvPh).*Ka_AvPh_Inc_Plaque;
[numAvPh_Inc_Plaque, denAvPh_Inc_Plaque] = tfdata(AvPh_Inc_Plaque,'v');

AvPh_FT_Inc_Plaque = AvPh_Inc_Plaque*FT_Inc_Plaque;
[numAvPh_FT_Inc_Plaque, denAvPh_FT_Inc_Plaque] = tfdata(AvPh_FT_Inc_Plaque,'v');

if showGraphicsAndData ==1
    disp('======Compensateur Multiple AvPh======')
    disp(['Avance de phase requise selon les spécifications = ', num2str(DeltaPhi_Inc_Plaque), ' deg'])
    disp(['Avance de phase requise / nb (car multiple AvPh) = ', num2str(DeltaPhi_Inc_Plaque./nb_AvPh), ' deg'])
    disp(' ')
    disp(['La position du zero de l`AvPh est ', num2str(Za_pos_Inc_Plaque)])
    disp(['La position du pôle de l`AvPh est ', num2str(Pa_pos_Inc_Plaque)])
    disp(['Le gain de l`AvPh est ', num2str(Ka_AvPh_Inc_Plaque)])
    disp(' ')
    disp('La fonciton de transfert de l`AvPh est : ')
    AvPh_Inc_Plaque
    % Affichage des figures
    if showIntermediaryGraphs == 1
        % Lieu des racines
        figure('Name','RootLocus FT theta et phi ainsi que une AvPh')
        hold on
        rlocus(FT_Inc_Plaque,'b')
        rlocus(AvPh_FT_Inc_Plaque,'r')
        p_des_avph_rl = rlocus(AvPh_FT_Inc_Plaque,1);
        plot(real(p_des_Inc_Plaque),imag(p_des_Inc_Plaque),'p','MarkerEdgeColor','b')
        plot(real(p_des_avph_rl),imag(p_des_avph_rl),'s','MarkerEdgeColor','g')
        legend('FT','FT + AvPh','Pôles désirés','Pôles obtenus','Location','North')
        title('RootLocus FT \theta et \Phi et FT une AvPh')
        axis([-600 600 -600 600])
        hold off
        % Lieu de Bode
        figure('Name','Lieu de Bode FT et FT + AvPh')
        hold on
        margin(FT_Inc_Plaque,'b')
        margin(AvPh_FT_Inc_Plaque,'r')
        legend('FT','Ft + AvPh')
        title('Lieu de Bode de la FT et FT + AvPH')
        grid on
        hold off
    end
end


% ===============Compensateur PI Simple===============
Zpi_Inc_Plaque = real(s_des_Inc_Plaque)./F_Inc_Plaque; % PI SIMPLE
% Kpos_now_Inc_Plaque = numAvPh_FT_Inc_Plaque(end)./denAvPh_FT_Inc_Plaque(end);
% Kvel_des_Inc_Plaque = 10000;
% Zpi_Inc_Plaque = real(s_des_Inc_Plaque)./F_Inc_Plaque;
% Ki_Inc_Plaque = Kvel_des_Inc_Plaque./Kpos_now_Inc_Plaque;
% Kp_Inc_Plaque = -Ki_Inc_Plaque./Zpi_Inc_Plaque;
% numPI_Inc_Plaque = Kp_Inc_Plaque*[1 -Zpi_Inc_Plaque];
numPI_Inc_Plaque = [1 -Zpi_Inc_Plaque];
denPI_Inc_Plaque = [1 0];
PI_Inc_Plaque = tf(numPI_Inc_Plaque,denPI_Inc_Plaque);

AvPh_FT_PI_Inc_Plaque = AvPh_FT_Inc_Plaque*PI_Inc_Plaque;


if showGraphicsAndData == 1
    disp('==========Compensateur PI==========')
%     disp(' ')
%     disp(['Kpos actuel = ', num2str(Kpos_now_Inc_Plaque)])
%     disp(['Kvel désiré = ', num2str(Kvel_des_Inc_Plaque)])
%     disp(['Ki desiré = ', num2str(Ki_Inc_Plaque)])
%     disp(['Kp désiré = ', num2str(Kp_Inc_Plaque)])
    disp(' ')
    disp('La fonction de transfert du PI est : ')
    PI_Inc_Plaque
    % Affichage des figures
    % Lieu des racines
    figure('Name','RootLocus FT theta et phi ainsi que leur PI')
    hold on
    rlocus(FT_Inc_Plaque,'b')
    rlocus(AvPh_FT_Inc_Plaque,'r')
    rlocus(AvPh_FT_PI_Inc_Plaque,'g')
    p_des_avph_pi_rl = rlocus(AvPh_FT_PI_Inc_Plaque,1);
    plot(real(p_des_I nc_Plaque),imag(p_des_Inc_Plaque),'p','MarkerEdgeColor','b')
    plot(real(p_des_avph_rl),imag(p_des_avph_rl),'s','MarkerEdgeColor','r')
    plot(real(p_des_avph_pi_rl),imag(p_des_avph_pi_rl),'s','MarkerEdgeColor','g')
    legend('FT','FT + AvPh','FT + AvPh + PI','Pôles désirés','Pôles obtenus (AvPh)','Pôles Obtenus (AvPh PI)','Location','North')
    title('RootLocus FT \theta et \Phi , une AvPh et leur PI')
    axis([-600 600 -600 600])
    hold off
    % Lieu de Bode
    figure('Name','Lieu de Bode')
    hold on
    margin(FT_Inc_Plaque,'b')
    margin(AvPh_FT_Inc_Plaque,'r')
    margin(AvPh_FT_PI_Inc_Plaque,'g')
    legend('FT','Ft + AvPh','Ft + AvPh + PI')
    title('Lieu de Bode de la FT, FT + AvPH et FT + AvPh + PI')
    grid on
    hold off   
end

% =====Calcul des parametres securité======
[Gm_AvPh_FT_PI_Inc_Plaque, Pm_AvPh_FT_PI_Inc_Plaque,~,~] = margin(AvPh_FT_PI_Inc_Plaque);
if showGraphicsAndData == 1
    disp('====CALCUL DES PARAMÈTRES DE SÉCURITÉ======')
    disp(['La PM initial du systeme complet est : ', num2str(Pm_AvPh_FT_PI_Inc_Plaque), ' deg'])
    disp(['La GM initial du systeme complet est : ', num2str(20*log10(Gm_AvPh_FT_PI_Inc_Plaque)), ' db'])
    disp(' ')
end

% =====Simulation=====
if useLocalResponseSimulation == 1
    PI_FT_FB = feedback(AvPh_FT_PI_Inc_Plaque,1);
    t_start = 0;
    t_step = 0.001;
    t_end = 2;
    t = [t_start:t_step:t_end];
    u = ones(size(t));
    % u = t;
    % u = t.^2;
    [num_PI_FT_FB, den_PI_FT_FB] = tfdata(PI_FT_FB,'v');
    simu = lsim(num_PI_FT_FB,den_PI_FT_FB,u,t);
    simuinfos = lsiminfo(simu,t);
    Mp_simu = (max(simu)-simu(end))/simu(end);
    if showGraphicsAndData == 1
        disp('=======SIMULATION=======')
        figure('Name','Réponse à une entrée unitaire')
        hold on
        plot(t,simu,'b')
        yline(0.98.*simu(end),'r--')
        yline(1.02.*simu(end),'r--')
        xlabel('Time')
        ylabel('Réponse')
        title('Réponse à une entrée unitaire')
        grid on
        hold off
        disp(['ts(2%) = ', num2str(simuinfos.SettlingTime), ' s', ' (vs ', num2str(ts2pc_Inc_Plaque), ' s)'])
        disp(['Mp = ' num2str(Mp_simu.*100), ' %', ' (vs ', num2str(Mp_Inc_Plaque), ' %)'])
        disp(' ')
    end
end

