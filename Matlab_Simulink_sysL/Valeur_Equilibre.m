% Observation:
% Lorsque la hauteur de l'actionneur est de 10mm ou moins, il n'y a aucune
% solution de courant valide (aucun courant négatif). Donc une
% post-validation du calcul devra être fait avant d'être accepté comme
% valeur.

Constante_L
load("donnees_prof_nl.mat");

% Entrez les valeurs à l'équilibre voulu. 
Px_sphere = 0;
Py_sphere = 0;
Pz_plaque = 0.015;
Ax_eq = 0.05;
Ay_eq = 0;


Matrice_X = [1 1 1;
                0 YB YC;
                XA XB XC];
Matrice_Y = [-Fg_total;
            -Fg_sphere*Py_sphere;
            -Fg_sphere*Px_sphere];
Matrice_Force = linsolve(Matrice_X, Matrice_Y);

zA = Pz_plaque - XA*Ay_eq + YA*Ax_eq;
zB = Pz_plaque - XB*Ay_eq + YB*Ax_eq;
zC = Pz_plaque - XC*Ay_eq + YC*Ax_eq;

C_i2A = -1/(ae0 + ae1*zA + ae2*zA^2 + ae3*zA^3);
C_i1A = be/(ae0 + ae1*zA + ae2*zA^2 + ae3*zA^3);
C_i0A = -Matrice_Force(1) + -1/(as0 + as1*zA + as2*zA^2 + as3*zA^3);

i_A = roots([C_i2A C_i1A C_i0A]);
idx = i_A>=0;
i_A(idx) = [];

C_i2B = -1/(ae0 + ae1*zB + ae2*zB^2 + ae3*zB^3);
C_i1B = be/(ae0 + ae1*zB + ae2*zB^2 + ae3*zB^3);
C_i0B = -Matrice_Force(1) + -1/(as0 + as1*zB + as2*zB^2 + as3*zB^3);


i_B = roots([C_i2B C_i1B C_i0B]);
idx = i_B>=0;
i_B(idx) = [];

C_i2C = -1/(ae0 + ae1*zC + ae2*zC^2 + ae3*zC^3);
C_i1C = be/(ae0 + ae1*zC + ae2*zC^2 + ae3*zC^3);
C_i0C = -Matrice_Force(1) + -1/(as0 + as1*zC + as2*zC^2 + as3*zC^3);

i_C = roots([C_i2C C_i1C C_i0C]);
idx = i_C>=0;
i_C(idx) = [];


