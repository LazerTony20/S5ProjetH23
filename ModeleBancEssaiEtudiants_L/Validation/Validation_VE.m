clear all

load("donnees_prof_nl.mat")
load("Sorties_zDEF.mat")
load("Variable_etat_lineaire.mat")


%% Validation Ax

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,1))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Ax)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Ay

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,2))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Ay)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Pz

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,3))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Pz)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


%% Validation Wx

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,4))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Wx)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


%% Validation Wy

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,5))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Wy)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Vz

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,6))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Vz)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Px

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,7))
title('Valeurs de Variable Ax de la simulation linéaire')
grid on


subplot(2,1,2)
hold on
plot(tsim, Px)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


%% Validation Py

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,8))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Py)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Vx

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,9))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Vx)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Vy

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,10))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, Vy)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Ia

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,11))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, IA)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Ib

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,12))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, IB)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on

%% Validation Ic

figure()
subplot(2,1,1)
hold on
plot(Vetats.time, Vetats.data(:,13))
title('Valeurs de Variable Ax de la simulation linéaire')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on


subplot(2,1,2)
hold on
plot(tsim, IC)
title('Valeurs de Variable Ax de la simulation non linéaire du prof')
legend('Courbe théorique sur Matlab', 'Courbe de la sortie de la Simulation')
grid on




