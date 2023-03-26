% Observation:
% Lorsque la hauteur de l'actionneur est de 10mm ou moins, il n'y a aucune
% solution de courant valide (aucun courant négatif). Donc une
% post-validation du calcul devra être fait avant d'être accepté comme
% valeur.

%%Décommentez cette ligne si on roule pas à partir du banc d'essaie
% Position à l'équilibre de la sphère (pour tests statiques)
sig = 1.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

%Point d'opération choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

Matrice_X = [1 1 1;
                0 YB YC;
                XA XB XC];
Matrice_Y = [-Fg_total;
            -Fg_sphere*ySeq;
            -Fg_sphere*xSeq];
Matrice_Force = linsolve(Matrice_X, Matrice_Y);

zA_e = Pzeq - XA*Ayeq + YA*Axeq;
zB_e = Pzeq - XB*Ayeq + YB*Axeq;
zC_e = Pzeq - XC*Ayeq + YC*Axeq;
zD_e  = Pzeq - XD*Ayeq + YD*Axeq;
zE_e  = Pzeq - XE*Ayeq + YE*Axeq;
zF_e  = Pzeq - XF*Ayeq + YF*Axeq;


K_i2A = -1/(ae0 + ae1*zA_e + ae2*zA_e^2 + ae3*zA_e^3);
K_i1A = be/(ae0 + ae1*zA_e + ae2*zA_e^2 + ae3*zA_e^3);
K_i0A = -Matrice_Force(1) + -1/(as0 + as1*zA_e + as2*zA_e^2 + as3*zA_e^3);

i_A = roots([K_i2A K_i1A K_i0A]);
idx = i_A>=0;
i_A(idx) = [];

K_i2B = -1/(ae0 + ae1*zB_e + ae2*zB_e^2 + ae3*zB_e^3);
K_i1B = be/(ae0 + ae1*zB_e + ae2*zB_e^2 + ae3*zB_e^3);
K_i0B = -Matrice_Force(1) + -1/(as0 + as1*zB_e + as2*zB_e^2 + as3*zB_e^3);


i_B = roots([K_i2B K_i1B K_i0B]);
idx = i_B>=0;
i_B(idx) = [];

K_i2C = -1/(ae0 + ae1*zC_e + ae2*zC_e^2 + ae3*zC_e^3);
K_i1C = be/(ae0 + ae1*zC_e + ae2*zC_e^2 + ae3*zC_e^3);
K_i0C = -Matrice_Force(1) + -1/(as0 + as1*zC_e + as2*zC_e^2 + as3*zC_e^3);

i_C = roots([K_i2C K_i1C K_i0C]);
idx = i_C>=0;
i_C(idx) = [];

Ia_e = i_A;
Ib_e = i_B;
Ic_e = i_C;
Va_e = RR*Ia_e;
Vb_e  = RR*Ib_e;
Vc_e = RR*Ic_e;
Ax_e = 0;
Ay_e = 0;
Wx_e = 0;
Wy_e = 0;
Vz_e = 0;
Px_e = xSeq;
Py_e = ySeq;
Pz_e = Pzeq;
Vx_e = 0;
Vy_e = 0;



