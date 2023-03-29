clear all
close all
clc

wn_corr = 700;
zeta_corr = 0.005;
delta_phi_add = 42;
Kp_modif = 0;
Ka_modif = 0;
F = 12;


MaxP = 5;
ts2 = 0.030;
tp = 0.025;
tr1090 = 0.020;

phi = atand(-pi/log(MaxP/100));
zeta = cosd(phi);

wn_ts2 = 4/(zeta*ts2);
wn_tp = pi/(tp*(1-zeta^2)^0.5);
wn_tm1090 = (1 + 1.1*zeta + 1.4*zeta*zeta^2)/tr1090;

wn = max([wn_ts2 wn_tp wn_tm1090]);

wn = wn + wn_corr;
zeta = zeta + zeta_corr

pdes = -zeta*wn + i*wn*(1 - zeta^2)^0.5;

num_G = [9744];
den_G = [1 31.3 -1767 -55320];
G = tf(num_G, den_G);


angle_G = rad2deg(angle(polyval(num_G, pdes))-angle(polyval(den_G, pdes)))-360;
delta_phi = -180-angle_G +delta_phi_add;
delta_phi = delta_phi/2;
alpha = 180-phi;
phi_z = (alpha + delta_phi)/2;
phi_p = (alpha - delta_phi)/2;
z = real(pdes) - imag(pdes)/tand(phi_z);
p = real(pdes) - imag(pdes)/tand(phi_p);

num_Ga = [1 -z];
den_Ga = [1 -p];


% figure();
% hold on
% Ga_Test = tf(num_Ga, den_Ga);
% rlocus(Ga_Test*Ga_Test*G);
% plot(real(pdes), imag(pdes), 'p')

n1 = abs(polyval(num_G, pdes));
n2 = abs(polyval(num_Ga, pdes));
d1 = abs(polyval(den_G, pdes));
d2 = abs(polyval(den_Ga, pdes));
Ka = (1/(n1*n2*n2/(d1*d2*d2)))+Ka_modif;

num_Ga = (Ka^0.5)*num_Ga;
den_Ga = den_Ga;
Ga = tf(num_Ga, den_Ga);

% figure();
% hold on
% rlocus(Ga*Ga*G);
% plot(real(pdes), imag(pdes), 'p')
% p_1 = rlocus(Ga*Ga*G, 1);
% plot(real(p_1), imag(p_1), 'square')


Ga2G = Ga*Ga*G;

% figure()
% hold on
% stepinfo(feedback(Ga2G,1))
% step(feedback(Ga2G,1))

% Création du PI

[num_Ga2G, den_Ga2G] = tfdata(Ga2G, 'v');
z = real(pdes)/F;
kp = 1 + Kp_modif;

num_Gpi = kp*[1 -z];
den_Gpi = [1 0];
Gpi = tf(num_Gpi, den_Gpi);

GpiGa2G = Gpi*Ga2G;

figure()
hold on
stepinfo(feedback(GpiGa2G,1))
t = [0:0.0001:0.1];
u = ones(size(t));
lsim(feedback(GpiGa2G,1), u, t)
[Gm,Pm,Wcg,Wcp] = margin(GpiGa2G)

