Constante_L
%load("donnees_prof_nl.mat");
% Entrez les valeurs à l'équilibre voulu. 
Px_sphere = 0;
Py_sphere = 0;
Pz_plaque = 0.015;
Ax_eq = 0;
Ay_eq = 0;
%
Valeur_Equilibre

%Format des vecteurs:
%[delta_aX delta_aY delta_Pz delta_aX' delta_aY' delta_Pz' delta_Px delta_Py delta_Px' delta_Py' delta_IA delta_IB delta_IC]
%[delta_Va delta_Vb delta_Vc]

%Delta_Ax'
delta_dAx = [0 0 0 1 0 0 0 0 0 0 0 0 0 ];

%delta_Ay'
delta_dAy = [0 0 0 0 1 0 0 0 0 0 0 0 0];

%delta_Az'
delta_dAz = [0 0 0 0 0 1 0 0 0 0 0 0 0];

% Équation linéaire des Forces
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
C2_deltaAy = YB*FB_L(1)+YC*FC_L(1);
C2_deltaIA = FA_L(2);
C2_deltaIB = FB_L(2);
C2_deltaIC = FC_L(2);
delta_ddAz = (1/masseTotal)*[ C2_detltaAx C2_deltaAy C2_deltaZ 0 0 0 0 0 0 0 C2_deltaIA C2_deltaIB C2_deltaIC];

%Pour delta Ay'' (theta)
C3_deltaZ = (FB_L(1)*YB + FC_L(1)*YC);
C3_detltaAx = -1*(FB_L(1)*YB*XB + FC_L(1)*YC*XC);
C3_deltaAy = (FB_L(1)*YB*YB + FC_L(1)*YC*YC);
C3_deltaPx = Fg_sphere;
C3_deltaIB = FB_L(2)*YB;
C3_deltaIC = FC_L(2)*YC;
delta_ddAy = (1/inertieP)*[C3_detltaAx C3_deltaAy C3_deltaZ  0 0 0 0 C3_deltaPx  0 0 0 C3_deltaIB C3_deltaIC];

%Pour delta Ax'' (phi)
C4_deltaZ = (FA_L(1)*YA+FB_L(1)*YB + FC_L(1)*YC);
C4_detltaAx = -1*(FA_L(1)*XA*XA+FB_L(1)*XB*XB + FC_L(1)*XC*XC);
C4_deltaAy = (FA_L(1)*XA*YA+FB_L(1)*XB*YB + FC_L(1)*XC*YC);
C4_deltaPy = -Fg_sphere;
C4_deltaIA = FA_L(2)*XA;
C4_deltaIB = FB_L(2)*XB;
C4_deltaIC = FC_L(2)*XC;
delta_ddAx = (1/inertieP)*[C4_detltaAx C4_deltaAy C4_deltaZ 0 0 0  C4_deltaPy 0 0 0  C4_deltaIA C4_deltaIB C4_deltaIC];

%Equation pour delta_Px'
delta_dPx = [0 0 0 0 0 0 0 0 1 0 0 0 0];

%Equation pour delta_Py'
delta_dPy = [0 0 0 0 0 0 0 0 0 1 0 0 0];

%Equation pour delta_Px''
C5_Fgs_meff = Fg_sphere/masseSeff;
delta_ddPx = [0 -C5_Fgs_meff 0 0 0 0 0 0 0 0 0 0 0];

%Equation pour delta_Py''
delta_ddPy = [C5_Fgs_meff 0 0 0 0 0 0 0 0 0 0 0 0];

%Équation des courants'
C0_va = 1/LL;
C0_ia = -RR/LL;
delta_dia = [0 0 0 0 0 0 0 0 0 0 C0_ia 0 0];

C0_vb = 1/LL;
C0_ib = -RR/LL;
delta_dib = [0 0 0 0 0 0 0 0 0 0 0 C0_ib 0];

C0_vc = 1/LL;
C0_ic = -RR/LL;
delta_dic = [0 0 0 0 0 0 0 0 0 0 0 0 C0_ic];


%Creation de la matrice A
A_lineaire = [
    delta_dAx;
    delta_dAy;
    delta_dAz;
    delta_ddAx;
    delta_ddAy;
    delta_ddAz;
    delta_dPx;
    delta_dPy;
    delta_ddPx;
    delta_ddPy;
    delta_dia;
    delta_dib;
    delta_dic];
B_lineaire = [
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    1/LL 0 0;
    0 1/LL 0;
    0 0 1/LL];

C_lineaire = [
    YD -XD 1 0 0 0 0 0 0 0 0 0 0;
    0 -XE 1 0 0 0 0 0 0 0 0 0 0;
    YF -XF 1 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 0 0 0 0 0;
    0 0 0 0 0 0 0 0 1 0 0 0 0
    0 0 0 0 0 0 0 0 0 1 0 0 0];

D_lineaire = zeros(7,3);
D_variable_etat = zeros(13,3);
C_variable_etat = eye(13,13);







