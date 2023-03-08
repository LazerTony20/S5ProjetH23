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