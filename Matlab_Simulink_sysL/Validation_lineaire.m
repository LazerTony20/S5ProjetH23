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

Ia_e = IA(1);
Ib_e = IB(1);
Ic_e = IC(1);
Za_e = zA(1);
Zb_e = zB(1);
Zc_e = zC(1);

C1_zsA = -(as1 + 2*as2*Za_e +3*as3*Za_e^2)/(as0 + as1*Za_e + as2*Za_e^2 +as3*Za_e^3)^2;
C1_zeA = -(Ia_e*abs(Ia_e) + be*Ia_e)*(ae1 + 2*ae2*Za_e +3*ae3*Za_e^2)/(ae0 + ae1*Za_e + ae2*Za_e^2 +ae3*Za_e^3)^2;
C1_ieA = (2*Ia_e + be)/(ae0 + ae1*Za_e + ae2*Za_e^2 +ae3*Za_e^3);
C1_zA = C1_zsA + C1_zeA;
C1_iA = C1_ieA;
FA_L = [C1_zA, C1_iA];

C1_zsB = -(as1 + 2*as2*Zb_e +3*as3*Zb_e^2)/(as0 + as1*Zb_e + as2*Zb_e^2 +as3*Zb_e^3)^2;
C1_zeB = -(Ib_e*abs(Ib_e) + be*Ib_e)*(ae1 + 2*ae2*Zb_e +3*ae3*Zb_e^2)/(ae0 + ae1*Zb_e + ae2*Zb_e^2 +ae3*Zb_e^3)^2;
C1_ieB = (2*Ib_e + be)/(ae0 + ae1*Zb_e + ae2*Zb_e^2 +ae3*Zb_e^3);
C1_zB = C1_zsB + C1_zeB;
C1_iB = C1_ieB;
FB_L = [C1_zB, C1_iB];

C1_zsC = -(as1 + 2*as2*Zc_e +3*as3*Zc_e^2)/(as0 + as1*Zc_e + as2*Zc_e^2 +as3*Zc_e^3)^2;
C1_zeC = -(Ic_e*abs(Ic_e) + be*Ia_e)*(ae1 + 2*ae2*Zc_e +3*ae3*Zc_e^2)/(ae0 + ae1*Zc_e + ae2*Zc_e^2 +ae3*Zc_e^3)^2;
C1_ieC = (2*Ic_e + be)/(ae0 + ae1*Zc_e + ae2*Zc_e^2 +ae3*Zc_e^3);
C1_zC = C1_zsC + C1_zeC;
C1_iC = C1_ieC;
FC_L = [C1_zC, C1_iC];

figure()
hold on

subplot(2,1,1)
FA_lin = FA_L(1).*((Pz - Pz_e) - XA.*(Ay)) + FA_L(2).*(IA - Ia_e) + FA(1);
plot(tsim, FA_lin)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot(tsim, FA)
title("Courbe de données du banc d'essaie")

figure()
hold on
subplot(2,1,1)
FB_lin = FB_L(1).*((Pz - Pz_e) - XB.*(Ay) + YB.*(Ax)) + FB_L(2).*(IB - Ib_e) + FB(1);
plot(tsim, FB_lin)
title("Courbe de données pour la fonction linéaire de FB")
subplot(2,1,2)
plot(FB)
title("Courbe de données du banc d'essaie")

figure()
hold on
subplot(2,1,1)
FC_lin = FC_L(1).*((Pz - Pz_e) - XC.*(Ay) + YC.*(Ax)) + FC_L(2).*(IC - Ic_e) + FC(1);
plot(tsim, FC_lin)
title("Courbe de données pour la fonction linéaire FC")
subplot(2,1,2)
plot(tsim, FC)
title("Courbe de données du banc d'essaie")

figure()
plot(FA_lin + FB_lin + FC_lin + Fg_total)