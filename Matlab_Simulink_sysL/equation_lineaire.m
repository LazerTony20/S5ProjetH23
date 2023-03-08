Constante_L
% Le fichier matlab qui permet de calculer les conditions d'équilibre
% devront être appelé ici
Ia_e = 0;
Ib_e = 0;
Ic_e = 0;
Za_e = 0;
Zb_e = 0;
Zc_e = 0;
Ax_e = 0;
Ay_e = 0;
Wx_e = 0;
Wy_e = 0;
Px_e = 0;
Py_e = 0;
Pz_e = 0;
Vx_e = 0;
Vy_e = 0;

%Format des vecteurs:
%[delta_aX delta_aY delta_Pz delta_aX' delta_aY' delta_Pz' delta_Px delta_Py delta_Px' delta_Py' delta_IA delta_IB delta_IC]
%[delta_Va delta_Vb delta_Vc]

%Delta_Ax'
delta_dAx = [0 0 0 1 0 0 0 0 0 0 0 0 0];

%delta_Ay'
delta_dAy = [0 0 0 0 1 0 0 0 0 0 0 0 0];

%delta_Az'
delta_dAz = [0 0 0 0 0 1 0 0 0 0 0 0 0];

% Équation linéaire des Forces
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
C2_deltaAy = YB*FB_L(1)+YC*FC_L(1);
C2_deltaIA = FA_L(2);
C2_deltaIB = FB_L(2);
C2_deltaIC = FC_L(2);
delta_ddAz = (1/masseTotal)*[C2_deltaZ C2_detltaAx C2_deltaAy 0 0 0 0 0 0 0 C2_deltaIA C2_deltaIB C2_deltaIC];

%Pour delta Ay'' (theta)
C3_deltaZ = (FB_L(1)*YB + FC_L(1)*YC);
C3_detltaAx = -1*(FB_L(1)*YB*XB + FC_L(1)*YC*XC);
C3_deltaAy = (FB_L(1)*YB*YB + FC_L(1)*YC*YC);
C3_deltaPx = Fg_sphere;
C3_deltaIB = FB_L(2)*YB;
C3_deltaIC = FC_L(2)*YC;
delta_ddAy = (1/inertieP)*[C3_deltaZ C3_detltaAx C3_deltaAy 0 0 0 C3_deltaPx 0 0 0 0 C3_deltaIB C3_deltaIC];

%Pour delta Ax'' (phi)
C4_deltaZ = (FA_L(1)*YA+FB_L(1)*YB + FC_L(1)*YC);
C4_detltaAx = -1*(FA_L(1)*XA*XA+FB_L(1)*XB*XB + FC_L(1)*XC*XC);
C4_deltaAy = (FA_L(1)*XA*YA+FB_L(1)*XB*YB + FC_L(1)*XC*YC);
C4_deltaPy = Fg_sphere;
C4_deltaIA = FA_L(2)*YA;
C4_deltaIB = FB_L(2)*YB;
C4_deltaIC = FC_L(2)*YC;
delta_ddAx = (1/inertieP)*[C4_deltaZ C4_detltaAx C4_deltaAy 0 0 0 0 C4_deltaPy 0 0 C4_deltaIA C4_deltaIB C4_deltaIC];

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
A = [
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
    delta_dic]






