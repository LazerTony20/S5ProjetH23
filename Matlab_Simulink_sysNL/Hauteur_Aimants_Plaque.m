clc
close all
clear all

load("donnees_prof_nl.mat")
%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises
r_abc = 95.2*10^-3;
r_def = 80*10^-1;

Xa = r_abc;
Ya = 0;
Za = 0;
Xb = -r_abc*sin(deg2rad(30));
Yb = r_abc*cos(deg2rad(30));
Zb = 0;
Xc = -r_abc*sin(deg2rad(30));
Yc = -r_abc*cos(deg2rad(30));
Zc = 0;

Xd = r_def*sind(30);
Yd = r_def*cosd(30);
Xe = -r_def*sind(30);
Ye = 0
Xf = r_def*sind(30);
Yf = -r_def*cosd(30);



%%%%%%%%%%%%%%%%


X_ai = Xa;
Y_ai = Ya;
X_bi = Xb;
Y_bi = Yb;
X_ci = Xc;
Y_ci = Yc;

%% Test de la conversion de position (Version matlab)
z_a = Pz - Xa.*Ay + Ya.*Ax;
z_b = Pz - Xb.*Ay + Yb.*Ax;
z_c = Pz - Xc.*Ay + Yc.*Ax;
z_d = Pz - Xd.*Ay + Yd.*Ax;
z_e = Pz - Xe.*Ay + Ye.*Ax;
z_f = Pz - Xf.*Ay + Yf.*Ax;

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_a)
subplot(2,1,2)
plot(tsim, zA)

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_b)
subplot(2,1,2)
plot(tsim, zB)

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_c)
subplot(2,1,2)
plot(tsim, zC)

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_d)
subplot(2,1,2)
plot(tsim, zD)

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_e)
subplot(2,1,2)
plot(tsim, zE)

figure();
hold on;
subplot(2,1,1)
plot(tsim, z_f)
subplot(2,1,2)
plot(tsim, zF)