Constante_L
load("Matrices_lineaire.mat");

U = [0 YB YC;
    -XA -XB -XC;
    1 1 1];

U_inv = inv(U);


PP = A_lineaire(4:6,1:3);
PS = A_lineaire(4:6, 7:8);
PC = A_lineaire(4:6, 11:13);
SP = A_lineaire(9:10, 1:3);
CC = A_lineaire(11:13, 11:13);
CV = B_lineaire(11:13, 1:3);
PC_diag = PC*U_inv;




