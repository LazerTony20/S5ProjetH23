Constante_L
load("donnees_prof_nl.mat");
% Entrez les valeurs à l'équilibre voulu. 
Px_sphere = 0;
Py_sphere = 0;
Pz_plaque = 0.015;
Ax_eq = 0;
Ay_eq = 0;
%

Valeur_Equilibre

delta_VA = timeseries((VA-Vc_e), tsim);
delta_VB = timeseries((VB-Vb_e), tsim);
delta_VC = timeseries((VC-Vc_e), tsim);
delta_Vk =delta_VA;
simout = sim("Test_courant", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');

figure()
hold on
subplot(2,1,1);
plot(simout.delta_Ik.time, simout.delta_Ik.data + Ia_e)
title("Test")
subplot(2,1,2);
plot(tsim, IB)

A_matrix = [delta_dia(end-2:end);
            delta_dib(end-2:end);
            delta_dic(end-2:end)]
 B_matrix = [1/LL 0 0;
             0 1/LL 0;
             0 0 1/LL]
C_matrix = [1 0 0;
            0 1 0;
            0 0 1]
D_matrix = [0 0 0;
            0 0 0;
            0 0 0]


figure()
hold on
subplot(2,1,1);
simout = sim("test_ABCD", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');
plot(simout.delta_iA.time, simout.delta_iA.data + Ia_e)
subplot(2,1,2);
plot(tsim, IA)