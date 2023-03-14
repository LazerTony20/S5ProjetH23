Constante_L
load("Matrices_lineaire.mat");
Valeur_Equilibre


U = [0 YB YC;
    -XA -XB -XC;
    1 1 1];

U_inv = inv(U);

PP = A_lineaire(4:6,1:3);
PC = A_lineaire(4:6, 11:13);
SP = A_lineaire(9:10, 1:3);
CC = A_lineaire(11:13, 11:13);
CV = B_lineaire(11:13, 1:3);
PC = PC*U_inv;

T_DEF_T = [YD -XD 1;
           YE -XE 1;
           YF -XF 1]


A_Ax = [[0 1 0];
    [2153.1 0 1273];
    [0 0 CC(1,1)]];
B_Ax = [0;0;CV(1,1)];
C_Ax = [1 0 0];
D_Ax = [0];

[num, den] = ss2tf(A_Ax, B_Ax, C_Ax, D_Ax);
TF_Ax = tf(num, den);
figure()
rlocus(TF_Ax)

A_Ax = [[0 1 0];
    [PP(1,1) 0 PC(1,1)];
    [0 0 CC(1,1)]];
B_Ax = [0;0;CV(1,1)];
C_Ax = [1 0 0];
D_Ax = [0];

[num, den] = ss2tf(A_Ax, B_Ax, C_Ax, D_Ax);
TF_Ax = tf(num, den);
figure()
rlocus(TF_Ax)
hm = findobj(gca, 'Type', 'Line');          % Handle To 'Line' Objects
hm(5).MarkerSize = 12;  
hm(4).MarkerSize = 12; 
hm(1).LineWidth = 2;
hm(2).LineWidth = 2;
hm(3).LineWidth = 2;
hm(4).LineWidth = 2;
hm(5).LineWidth = 2;
hm(6).LineWidth = 2;

title("Lieu des racines pour la Fonction de transfert de l'axe \phi", 'FontSize',20)
grid on
xlabel('Axe reel', 'FontSize',20)
ylabel('Axe imaginaire','FontSize',20)


A_Ay = [[0 1 0];
    [PP(2,2) 0 PC(2,2)];
    [0 0 CC(2,2)]];
B_Ay = [0;0;CV(2,2)];
C_Ay = [1 0 0];
D_Ay = [0];

[num, den] = ss2tf(A_Ay, B_Ay, C_Ay, D_Ay);
TF_Ay = tf(num, den);
figure()
rlocus(TF_Ay)

A_Az = [[0 1 0];
    [PP(3,3) 0 PC(3,3)];
    [0 0 CC(3,3)]];
B_Az = [0;0;CV(3,3)];
C_Az = [1 0 0];
D_Az = [0];

[num, den] = ss2tf(A_Az, B_Az, C_Az, D_Az);
TF_Az = tf(num, den);
figure()
rlocus(TF_Az)

A_Px = [0 1; 0 0];
B_Px = [0; SP(1,2)] %L'entrée est Ay
C_Px = [1 0;0 1];
D_Px = [0;0];

[num_px, den_px] = ss2tf(A_Px, B_Px, C_Px, D_Px);
TF_Px_1 = tf(num_px(1,:), den_px);
TF_Px_2 = tf(num_px(2,:), den_px);
figure()
rlocus(TF_Px_1)
hm = findobj(gca, 'Type', 'Line');          % Handle To 'Line' Objects
hm(4).MarkerSize = 12; 
hm(1).LineWidth = 2;
hm(2).LineWidth = 2;
hm(3).LineWidth = 2;
hm(4).LineWidth = 2;
hm(5).LineWidth = 2;


title("Lieu des racines pour la Fonction de transfert de l'axe xs pour la sortie Px", 'FontSize',20)
grid on
xlabel('Axe reel', 'FontSize',20)
ylabel('Axe imaginaire','FontSize',20)

figure()
rlocus(TF_Px_2)
hm = findobj(gca, 'Type', 'Line');          % Handle To 'Line' Objects 
hm(3).MarkerSize = 12; 
hm(4).MarkerSize = 12; 
hm(1).LineWidth = 2;
hm(2).LineWidth = 2;
hm(3).LineWidth = 2;
hm(4).LineWidth = 2;



title("Lieu des racines pour la Fonction de transfert de l'axe xs pour la sortie Vx", 'FontSize',20)
grid on
xlabel('Axe reel', 'FontSize',20)
ylabel('Axe imaginaire','FontSize',20)

A_Py = [0 1; 0 0];
B_Py = [0; SP(2,1)] %L'entrée est Ax
C_Py = [1 0;0 1];
D_Py = [0;0];

[num_py, den_py] = ss2tf(A_Py, B_Py, C_Py, D_Py);
TF_Py_1 = tf(num_py(1,:), den_py);
TF_Py_2 = tf(num_py(2,:), den_py);
figure()
rlocus(TF_Py_1)
hm = findobj(gca, 'Type', 'Line');          % Handle To 'Line' Objects
hm(4).MarkerSize = 12; 
hm(1).LineWidth = 2;
hm(2).LineWidth = 2;
hm(3).LineWidth = 2;
hm(4).LineWidth = 2;
hm(5).LineWidth = 2;


title("Lieu des racines pour la Fonction de transfert de l'axe ys pour la sortie Py", 'FontSize',20)
grid on
xlabel('Axe reel', 'FontSize',20)
ylabel('Axe imaginaire','FontSize',20)

figure()
rlocus(TF_Py_2)
hm = findobj(gca, 'Type', 'Line');          % Handle To 'Line' Objects
hm(3).MarkerSize = 12; 
hm(4).MarkerSize = 12; 
hm(1).LineWidth = 2;
hm(2).LineWidth = 2;
hm(3).LineWidth = 2;
hm(4).LineWidth = 2;


title("Lieu des racines pour la Fonction de transfert de l'axe ys pour la sortie Vy", 'FontSize',20)
grid on
xlabel('Axe reel', 'FontSize',20)
ylabel('Axe imaginaire','FontSize',20)








