Constante_L
load("donnees_prof_nl.mat");


Px_sphere = 0;
Py_sphere = 0;
Pz_plaque = 0.015;
Ax_eq = 0;
Ay_eq = 0;
%
Valeur_Equilibre

C1_zsA = -(as1 + 2*as2*zA_e +3*as3*zA_e^2)/(as0 + as1*zA_e + as2*zA_e^2 +as3*zA_e^3)^2;
C1_zeA = -(Ia_e*abs(Ia_e) + be*Ia_e)*(ae1 + 2*ae2*zA_e +3*ae3*zA_e^2)/(ae0 + ae1*zA_e + ae2*zA_e^2 +ae3*zA_e^3)^2;
C1_ieA = (2*Ia_e + be)/(ae0 + ae1*zA_e + ae2*zA_e^2 +ae3*zA_e^3);
C1_zA = C1_zsA + C1_zeA;
C1_iA = C1_ieA;
FA_L = [C1_zA, C1_iA];

C1_zsB = -(as1 + 2*as2*zB_e +3*as3*zB_e^2)/(as0 + as1*zB_e + as2*zB_e^2 +as3*zB_e^3)^2;
C1_zeB = -(Ib_e*abs(Ib_e) + be*Ib_e)*(ae1 + 2*ae2*zB_e +3*ae3*zB_e^2)/(ae0 + ae1*zB_e + ae2*zB_e^2 +ae3*zB_e^3)^2;
C1_ieB = (2*Ib_e + be)/(ae0 + ae1*zB_e + ae2*zB_e^2 +ae3*zB_e^3);
C1_zB = C1_zsB + C1_zeB;
C1_iB = C1_ieB;
FB_L = [C1_zB, C1_iB];

C1_zsC = -(as1 + 2*as2*zC_e +3*as3*zC_e^2)/(as0 + as1*zC_e + as2*zC_e^2 +as3*zC_e^3)^2;
C1_zeC = -(Ic_e*abs(Ic_e) + be*Ia_e)*(ae1 + 2*ae2*zC_e +3*ae3*zC_e^2)/(ae0 + ae1*zC_e + ae2*zC_e^2 +ae3*zC_e^3)^2;
C1_ieC = (2*Ic_e + be)/(ae0 + ae1*zC_e + ae2*zC_e^2 +ae3*zC_e^3);
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
delta_ddAz = (1/masseTotal).*[C2_deltaZ C2_detltaAx C2_deltaAy C2_deltaIA C2_deltaIB C2_deltaIC];

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
C4_deltaIA = FA_L(2)*YA;
C4_deltaIB = FB_L(2)*YB;
C4_deltaIC = FC_L(2)*YC;
delta_ddAx = (1/inertieP).*[C4_deltaZ C4_detltaAx C4_deltaAy C4_deltaPy C4_deltaIA C4_deltaIB C4_deltaIC];

figure()
hold on
subplot(2,1,1)
acc_Z = delta_ddAz(1).*(Pz - Pz_e) + delta_ddAz(2).*(Ay) + delta_ddAz(3).*(Ax) + delta_ddAz(4).*(IA - Ia_e) + delta_ddAz(5).*(IB - Ib_e) + delta_ddAz(6).*(IC - Ic_e) ;
plot(tsim,acc_Z)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot(tsim,(FA+FB+FC+Fg_total)/masseTotal)
title("Courbe de données du banc d'essaie")

figure()
hold on
subplot(2,1,1)
acc_Ay = delta_ddAy(1).*(Pz - Pz_e) + delta_ddAy(2).*(Ay) + delta_ddAy(3).*(Ax) + delta_ddAy(4).*(Py) + delta_ddAy(5).*(IB - Ib_e) + delta_ddAy(6).*(IC - Ic_e) ;
plot(tsim, acc_Ay)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot(tsim, (YB*FB+FC*YC+Fg_sphere.*Py)/inertieP)
title("Courbe de données du banc d'essaie")


acceleration = timeseries(acc_Z, tsim);
simout = sim("Test_dynamic_plaque", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');
figure()

hold on
subplot(2,1,1);
title("test")
plot(simout.int_value.time, simout.int_value.data)
subplot(2,1,2);
plot(tsim, Pz)

%%

Constante_L
load("donnees_prof_nl.mat");


Px_sphere = 0;
Py_sphere = 0;
Pz_plaque = 0.015;
Ax_eq = 0;
Ay_eq = 0;
%
Valeur_Equilibre

C1_zsA = -(as1 + 2*as2*zA_e +3*as3*zA_e^2)/(as0 + as1*zA_e + as2*zA_e^2 +as3*zA_e^3)^2;
C1_zeA = -(Ia_e*abs(Ia_e) + be*Ia_e)*(ae1 + 2*ae2*zA_e +3*ae3*zA_e^2)/(ae0 + ae1*zA_e + ae2*zA_e^2 +ae3*zA_e^3)^2;
C1_ieA = (2*Ia_e + be)/(ae0 + ae1*zA_e + ae2*zA_e^2 +ae3*zA_e^3);
C1_zA = C1_zsA + C1_zeA;
C1_iA = C1_ieA;
FA_L = [C1_zA, C1_iA];

C1_zsB = -(as1 + 2*as2*zB_e +3*as3*zB_e^2)/(as0 + as1*zB_e + as2*zB_e^2 +as3*zB_e^3)^2;
C1_zeB = -(Ib_e*abs(Ib_e) + be*Ib_e)*(ae1 + 2*ae2*zB_e +3*ae3*zB_e^2)/(ae0 + ae1*zB_e + ae2*zB_e^2 +ae3*zB_e^3)^2;
C1_ieB = (2*Ib_e + be)/(ae0 + ae1*zB_e + ae2*zB_e^2 +ae3*zB_e^3);
C1_zB = C1_zsB + C1_zeB;
C1_iB = C1_ieB;
FB_L = [C1_zB, C1_iB];

C1_zsC = -(as1 + 2*as2*zC_e +3*as3*zC_e^2)/(as0 + as1*zC_e + as2*zC_e^2 +as3*zC_e^3)^2;
C1_zeC = -(Ic_e*abs(Ic_e) + be*Ia_e)*(ae1 + 2*ae2*zC_e +3*ae3*zC_e^2)/(ae0 + ae1*zC_e + ae2*zC_e^2 +ae3*zC_e^3)^2;
C1_ieC = (2*Ic_e + be)/(ae0 + ae1*zC_e + ae2*zC_e^2 +ae3*zC_e^3);
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
delta_ddAz = (1/masseTotal).*[C2_deltaZ C2_detltaAx C2_deltaAy 0 0 0 C2_deltaIA C2_deltaIB C2_deltaIC];

%Pour delta Ay'' (theta)
C3_deltaZ = (FB_L(1)*YB + FC_L(1)*YC);
C3_detltaAx = -1*(FB_L(1)*YB*XB + FC_L(1)*YC*XC);
C3_deltaAy = (FB_L(1)*YB*YB + FC_L(1)*YC*YC);
C3_deltaPx = Fg_sphere;
C3_deltaIB = FB_L(2)*YB;
C3_deltaIC = FC_L(2)*YC;
delta_ddAy = (1/inertieP)*[C3_deltaZ C3_detltaAx C3_deltaAy C3_deltaPx 0 0 C3_deltaIB C3_deltaIC];

%Pour delta Ax'' (phi)
C4_deltaZ = (FA_L(1)*YA+FB_L(1)*YB + FC_L(1)*YC);
C4_detltaAx = -1*(FA_L(1)*XA*XA+FB_L(1)*XB*XB + FC_L(1)*XC*XC);
C4_deltaAy = (FA_L(1)*XA*YA+FB_L(1)*XB*YB + FC_L(1)*XC*YC);
C4_deltaPy = Fg_sphere;
C4_deltaIA = FA_L(2)*YA;
C4_deltaIB = FB_L(2)*YB;
C4_deltaIC = FC_L(2)*YC;
delta_ddAx = (1/inertieP).*[C4_deltaZ C4_detltaAx C4_deltaAy  0 C4_deltaPy C4_deltaIA C4_deltaIB C4_deltaIC];

figure()
hold on
subplot(2,1,1)
acc_Z = delta_ddAz(1).*(Pz - Pz_e) + delta_ddAz(2).*(Ay) + delta_ddAz(3).*(Ax) + delta_ddAz(4).*(IA - Ia_e) + delta_ddAz(5).*(IB - Ib_e) + delta_ddAz(6).*(IC - Ic_e) ;
plot(tsim,acc_Z)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot(tsim,(FA+FB+FC+Fg_total)/masseTotal)
title("Courbe de données du banc d'essaie")

figure()
hold on
subplot(2,1,1)
acc_Ay = delta_ddAy(1).*(Pz - Pz_e) + delta_ddAy(2).*(Ay) + delta_ddAy(3).*(Ax) + delta_ddAy(4).*(Py) + delta_ddAy(5).*(IB - Ib_e) + delta_ddAy(6).*(IC - Ic_e) ;
plot(tsim, acc_Ay)
title("Courbe de données pour la fonction linéaire de FA")
subplot(2,1,2)
plot(tsim, (YB*FB+FC*YC+Fg_sphere.*Py)/inertieP)
title("Courbe de données du banc d'essaie")


acceleration = timeseries(acc_Z, tsim);
simout = sim("Test_dynamic_plaque", "StartTime", '0', "StopTime", '50', "FixedStep", '0.0001');
figure()

hold on
subplot(2,1,1);
title("test")
plot(simout.int_value.time, simout.int_value.data)
subplot(2,1,2);
plot(tsim, Pz)
A_test = [delta_ddAx;
          delta_ddAy;
          delta_ddAz]
