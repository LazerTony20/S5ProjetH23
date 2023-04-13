syms XA XB XC YB YC C1_zA C1_iA C1_zB C1_iB C1_zC C1_iC
% rABC = 95.20e-03;  
% XA = +rABC;
% YA =  0.0;
% ZA =  0.0;
% XB = -rABC*sind(30);
% YB = +rABC*cosd(30);
% ZB =  0.0;
% XC = -rABC*sind(30);
% YC = -rABC*cosd(30);
% ZC =  0.0;

YA = 0
U = [0 YB YC;
    -XA -XB -XC;
    1 1 1];

U_adj = inv(U)





% Équation linéaire pour la dynamique de la plaque;
%Pour delta Z''
C2_deltaAx = YB*C1_zB+YC*C1_zC;
C2_deltaAy = (XA*C1_zA+XB*C1_zB+XC*C1_zC);
C2_deltaZ = C1_zA+C1_zB+C1_zC;
C2_deltaIA = C1_iA;
C2_deltaIB = C1_iB;
C2_deltaIC = C1_iC;
delta_ddAz_pp = (1/5)*[C2_deltaAx C2_deltaAy C2_deltaZ];
delta_ddAz_pc = (1/5)*[C2_deltaIA C2_deltaIB C2_deltaIC];

%Pour delta Ax'' (phi)
C3_deltaAx = (C1_zB*YB*YB + C1_zC*YC*YC);
C3_deltaAy = -1*(C1_zB*YB*XB + C1_zC*YC*XC);
C3_deltaZ = (C1_zB*YB + C1_zC*YC);
C3_deltaIB = C1_iB*YB;
C3_deltaIC = C1_iC*YC;
delta_ddAx_pp = (1/10)*[C3_deltaAx C3_deltaAy C3_deltaZ];
delta_ddAx_pc = (1/5)*[0 C3_deltaIB C3_deltaIC];

%Pour delta Ay'' (theta)
C4_deltaAx = (C1_zA*XA*YA+C1_zB*XB*YB + C1_zC*XC*YC);
C4_deltaAy = -1*(C1_zA*XA*XA+C1_zB*XB*XB + C1_zC*XC*XC);
C4_deltaZ = (C1_zA*YA+C1_zB*YB + C1_zC*YC);
C4_deltaIA = C1_iA*XA;
C4_deltaIB = C1_iB*XB;
C4_deltaIC = C1_iC*XC;
delta_ddAy_pp = (-1/10)*[C4_deltaAx C4_deltaAy C4_deltaZ];
delta_ddAy_pc = (1/5)*[C4_deltaIA C4_deltaIB C4_deltaIC];



A_pp = [delta_ddAx_pp;
    delta_ddAy_pp;
    delta_ddAz_pp]
result = simplify(A_pp);

A_pc = [delta_ddAx_pc;
    delta_ddAy_pc;
    delta_ddAz_pc]
result_2 = simplify(A_pc*U_adj)