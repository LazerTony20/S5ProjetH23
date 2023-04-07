clear all
close all
clc

load('capteur.mat')
%Tableau qui contient l'historique des identification
RMSE_values = [];
R2_value = [];
F_function = [];
alpha_value = [];
beta_value = [];


% Lissage des données
X = [];
Y = [];
for i=0:1:7
    X_line = [];
    for j=0:1:7
        X_line = [X_line sum(distance.^(i+j))];
    end
    X = [X; X_line];
    Y = [Y; sum((distance.^i).*voltage)];
end 
A = inv(X)*Y;
voltage_lis = A(1) + A(2).*distance + A(3).*distance.^2 + A(4).*distance.^3 + A(5).*distance.^4 + A(6).*distance.^5 + A(7).*distance.^6 + A(8).*distance.^7;


for i = 0:1:1000
    removed_value = i;
    V = voltage_lis(1:end-removed_value);
    V = abs(V-V(end));
    V(end) = 0.05;
    y = log(V);
    x = distance(1:end-removed_value);
    N = size(x);
    N = N(1);
    X = [N sum(x); sum(x) sum(x.^2)];
    Y = [sum(y); sum(y.*x)];
    A = inv(X)*Y;
    alpha = exp(A(1));
    alpha_value = [alpha_value alpha];
    beta = A(2);
    beta_value = [beta_value beta];
    test = alpha*exp(beta*distance);
    F = -test+voltage(end);
    F_function = [F_function F];
    RMSE = sqrt(mean((F-voltage).*(F-voltage)));
    RMSE_values = [RMSE_values RMSE];
    y_moy = 1/N * sum(voltage);
    R2 = 1-(sum((F-voltage).^2))/(sum((voltage-y_moy).^2));
    R2_value = [R2_value R2];
end

minimum_RMSE = min(RMSE_values);
best_R2 = max(R2_value);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);
[R2_x,R2_y] = find(R2_value == best_R2);

F_candidat =  F_function(:,RMSE_y);

figure()
hold on
plotGraphic(distance, F_candidat,'Courbe de l''approximation de l''exponentielle',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage,'Courbe de l''approximation de l''exponentielle',  ['Distance (mm)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Approximation par moindre carré '])
[~, ~] = error_Calculator(F_candidat, voltage)
disp(['Valeur de alpha :', num2str(alpha_value(RMSE_y))]);
disp(['Valeur de beta : ', num2str(beta_value(RMSE_y))])
disp(['----------------------------------------------Approximation par moindre carré '])


%% Correction de la fonction première itération
error = voltage-F_candidat;
error_test = 0.055*sin(distance./(0.025/2.75) + pi)+0.01 ;


figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de l''exponentielle',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test,'Courbe de l''erreur de l''approximation de l''exponentielle',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')


%% Résultats de la correction
F_first_corr = F_candidat+error_test;
figure()
hold on
plotGraphic(distance, F_first_corr,'Courbe de l''approximation de l''exponentielle: correction 1',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de l''exponentielle: correction 1'], ['Distance (mm)'], ['Voltage (V)'])

disp(['----------------------------------------------Résultats de la correction de L''erreur '])
[RMSE_abs,RMSE_rel, R2] = error_Calculator(F_first_corr,voltage);
disp(['----------------------------------------------Résultats de la correction de L''erreur '])
legend('Courbe de l''approximation', 'Courbe des données')

%% Correction de la fonction deuxième itération
error = voltage-F_first_corr;
error_test = 0.005*sin(2*pi*distance./(0.021))+0.5.*distance ;


figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de l''exponentielle : correction 1',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test,'Courbe de l''erreur de l''approximation de l''exponentielle : correction 1',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')

%% Résultats de la correction
F_sec_corr = F_first_corr+error_test;

figure()
hold on
plotGraphic(distance, F_sec_corr,'Courbe de l''approximation de l''exponentielle: correction 2',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de l''exponentielle: correction 2'], ['Distance (mm)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
[~,~] = error_Calculator(F_sec_corr(300:end),voltage(300:end));
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
















