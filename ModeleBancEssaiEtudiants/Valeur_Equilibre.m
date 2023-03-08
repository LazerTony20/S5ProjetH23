% Observation:
% Lorsque la hauteur de l'actionneur est de 10mm ou moins, il n'y a aucune
% solution de courant valide (aucun courant négatif). Donc une
% post-validation du calcul devra être fait avant d'être accepté comme
% valeur.

Matrice_X = [1 1 1;
                0 YB YC;
                XA XB XC];
Matrice_Y = [-Fg_total;
            -Fg_sphere*Py_sphere;
            -Fg_sphere*Px_sphere];
Matrice_Force = linsolve(Matrice_X, Matrice_Y);

zA_e = Pz_plaque - XA*Ay_eq + YA*Ax_eq;
zB_e = Pz_plaque - XB*Ay_eq + YB*Ax_eq;
zC_e = Pz_plaque - XC*Ay_eq + YC*Ax_eq;
zD_e  = Pz_plaque - XD*Ay_eq + YD*Ax_eq;
zE_e  = Pz_plaque - XE*Ay_eq + YE*Ax_eq;
zF_e  = Pz_plaque - XF*Ay_eq + YF*Ax_eq;


C_i2A = -1/(ae0 + ae1*zA_e + ae2*zA_e^2 + ae3*zA_e^3);
C_i1A = be/(ae0 + ae1*zA_e + ae2*zA_e^2 + ae3*zA_e^3);
C_i0A = -Matrice_Force(1) + -1/(as0 + as1*zA_e + as2*zA_e^2 + as3*zA_e^3);

i_A = roots([C_i2A C_i1A C_i0A]);
idx = i_A>=0;
i_A(idx) = [];

C_i2B = -1/(ae0 + ae1*zB_e + ae2*zB_e^2 + ae3*zB_e^3);
C_i1B = be/(ae0 + ae1*zB_e + ae2*zB_e^2 + ae3*zB_e^3);
C_i0B = -Matrice_Force(1) + -1/(as0 + as1*zB_e + as2*zB_e^2 + as3*zB_e^3);


i_B = roots([C_i2B C_i1B C_i0B]);
idx = i_B>=0;
i_B(idx) = [];

C_i2C = -1/(ae0 + ae1*zC_e + ae2*zC_e^2 + ae3*zC_e^3);
C_i1C = be/(ae0 + ae1*zC_e + ae2*zC_e^2 + ae3*zC_e^3);
C_i0C = -Matrice_Force(1) + -1/(as0 + as1*zC_e + as2*zC_e^2 + as3*zC_e^3);

i_C = roots([C_i2C C_i1C C_i0C]);
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
Px_e = Px_sphere;
Py_e = Py_sphere;
Pz_e = Pz_plaque;
Vx_e = 0;
Vy_e = 0;



