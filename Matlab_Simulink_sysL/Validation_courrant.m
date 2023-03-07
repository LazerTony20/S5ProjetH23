Constante_L
load("donnees_prof_nl.mat");

Ia_e = IA(1);


Vb_eq = VB(1);

delta_Vk = timeseries((VB-Vb_eq), tsim);
simout = sim("Test_courant", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');

figure()
hold on
subplot(2,1,1);
plot(simout.delta_Ik.time, simout.delta_Ik.data + Ia_e)
subplot(2,1,2);
plot(tsim, IB)
