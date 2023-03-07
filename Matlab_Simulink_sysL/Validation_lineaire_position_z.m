Constante_L
load("donnees_prof_nl.mat");

Ia_e = 0;
Ib_e = 0;
Ic_e = 0;
Ax_e = 0;
Ay_e = 0;
Wx_e = 0;
Wy_e = 0;
Px_e = 0;
Py_e = 0;
Pz_e = Pz(1);
Vx_e = 0;
Vy_e = 0;

figure()
hold on
subplot(2,1,1)
z_a = (Pz - Pz_e) - XA.*(Ay) + Pz;
plot(z_a)
subplot(2,1,2)
plot(zA)

figure()
hold on
subplot(2,1,1)
z_b = (Pz - Pz_e) - XB.*(Ay) + YB.*(Ax) + Pz;
plot(z_b)
subplot(2,1,2)
plot(zB)

figure()
hold on
subplot(2,1,1)
z_c = (Pz - Pz_e) - XC.*(Ay) + YC.*(Ax) + Pz;
plot(z_c)
subplot(2,1,2)
plot(zC)