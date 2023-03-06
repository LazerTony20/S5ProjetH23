Constante_L
load("donnees_prof_nl.mat");

Ia_e = IA(1);
Ib_e = IB(1);
Ic_e = IC(1);
Za_e = zA(1);
Zb_e = zB(1);
Zc_e = zC(1);
Pz_e = Pz(1);

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

% Équation linéaire pour la dynamique de la plaque;
%Pour delta Z''
C2_deltaZ = FA_L(1)+FB_L(1)+FC_L(1);
C2_detltaAx = -1*(XA*FA_L(1)+XB*FB_L(1)+XC*FC_L(1));
C2_deltaAy = (YB*FB_L(1)+YC*FC_L(1));
C2_deltaIA = FA_L(2);
C2_deltaIB = FB_L(2);
C2_deltaIC = FC_L(2);
delta_ddAz = (1/masseP).*[C2_deltaZ C2_detltaAx C2_deltaAy C2_deltaIA C2_deltaIB C2_deltaIC];

%Pour delta Ay'' (theta)
C3_deltaZ = (FB_L(1)*YB + FC_L(1)*YC);
C3_detltaAx = -1*(FB_L(1)*YB*XB + FC_L(1)*YC*XC);
C3_deltaAy = (FB_L(1)*YB*YB + FC_L(1)*YC*YC);
C3_deltaPx = Fg_sphere;
C3_deltaIB = FB_L(2)*YB;
C3_deltaIC = FC_L(2)*YC;
delta_ddAy = (1/inertieP)*[C3_deltaZ C3_detltaAx C3_deltaAy C3_deltaPx C3_deltaIB C3_deltaIC];

%Pour delta Ax'' (phi)
C4_deltaZ = (FA_L(1)*YA+FB_L(1)*YB + FC_L(1)*YC);
C4_detltaAx = -1*(FA_L(1)*XA*XA+FB_L(1)*XB*XB + FC_L(1)*XC*XC);
C4_deltaAy = (FA_L(1)*XA*YA+FB_L(1)*XB*YB + FC_L(1)*XC*YC);
C4_deltaPy = Fg_sphere;
C4_deltaIB = FA_L(2)*YA;
C4_deltaIB = FB_L(2)*YB;
C4_deltaIC = FC_L(2)*YC;
delta_ddAx = (1/inertieP).*[C2_deltaZ C2_detltaAx C2_deltaAy C4_deltaPy C2_deltaIA C2_deltaIB C2_deltaIC];

subplot(2,1,1)
value = delta_ddAz(1).*(Pz - Pz_e) + delta_ddAz(2).*(Ax) + delta_ddAz(3).*(Ay) + delta_ddAz(4).*(IA - Ia_e) + delta_ddAz(5).*(IB - Ib_e) + delta_ddAz(6).*(IC - Ic_e) + Fg_total/masseP ;
plot(value)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot((FA + FB + FC + Fg_total)/masseP)
title("Courbe de données du banc d'essaie")