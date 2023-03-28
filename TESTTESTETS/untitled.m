clear all
close all
clc

pdes_real = 0;
pdes_imag = 0i;
delta_phi_add = 18.5;


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

pdes = -zeta*wn + i*wn*(1 - zeta^2)^0.5 + (pdes_real + pdes_imag)

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
Ka = 1/(n1*n2*n2/(d1*d2*d2));

num_Ga = (Ka^0.5)*num_Ga;
den_Ga = den_Ga;
Ga = tf(num_Ga, den_Ga)

% figure();
% hold on
% rlocus(Ga*Ga*G);
% plot(real(pdes), imag(pdes), 'p')
% p_1 = rlocus(Ga*Ga*G, 1);
% plot(real(p_1), imag(p_1), 'square')


figure()
hold on
stepinfo(feedback(Ga*Ga*G,1))
step(feedback(Ga*Ga*G,1))
