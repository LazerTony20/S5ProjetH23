Constante_L
load("donnees_prof_nl.mat");

Ia_e = IA(1);


Vb_eq = VB(1);
Va_eq = VA(1);
Vc_eq = VC(1);

delta_VA = timeseries((VA-Vc_eq), tsim);
delta_VB = timeseries((VB-Vb_eq), tsim);
delta_VC = timeseries((VC-Vc_eq), tsim);
simout = sim("Test_courant", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');

figure()
hold on
subplot(2,1,1);
plot(simout.delta_Ik.time, simout.delta_Ik.data + Ia_e)
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
plot(simout.delta_iA1.time, simout.delta_iA1.data + Ia_e)
subplot(2,1,2);
plot(tsim, IB)