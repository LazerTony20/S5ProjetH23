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
        X_line = [X_line sum(voltage.^(i+j))];
    end
    X = [X; X_line];
    Y = [Y; sum((voltage.^i).*distance)];
end 
A = inv(X)*Y;
distance_lis = A(1) + A(2).*voltage + A(3).*voltage.^2 + A(4).*voltage.^3 + A(5).*voltage.^4 + A(6).*voltage.^5 + A(7).*voltage.^6 + A(8).*voltage.^7;


for i = 0:1:1000
    removed_value = i;
    V = distance_lis(1:end-removed_value);
    V = abs(V-V(1));
    V(1) = 0.000000001;
    y = log(V);
    x = voltage(1:end-removed_value);
    N = size(x);
    N = N(1);
    X = [N sum(x); sum(x) sum(x.^2)];
    Y = [sum(y); sum(y.*x)];
    A = inv(X)*Y;
    alpha = exp(A(1));
    alpha_value = [alpha_value alpha];
    beta = A(2);
    beta_value = [beta_value beta];
    test = alpha*exp(beta*voltage);
    F = -test+distance(1);
    F_function = [F_function F];
    RMSE = sqrt(mean((F-distance).*(F-distance)));
    RMSE_values = [RMSE_values RMSE];
    y_moy = 1/N * sum(distance);
    R2 = 1-(sum((F-distance).^2))/(sum((distance-y_moy).^2));
    R2_value = [R2_value R2];
end

minimum_RMSE = min(RMSE_values);
best_R2 = max(R2_value);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);
[R2_x,R2_y] = find(R2_value == best_R2);

F_candidat =  F_function(:,RMSE_y);

figure()
hold on
plotGraphic(voltage, F_candidat,'Courbe de l''approximation de l''exponentielle',  ['voltage (m)'], ['distance (V)'])
plotGraphic(voltage, distance,'Courbe de l''approximation de l''exponentielle',  ['voltage (m)'], ['distance (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Approximation par moindre carré '])
[~, ~] = error_Calculator(F_candidat, distance)
disp(['Valeur de alpha :', num2str(alpha_value(RMSE_y))]);
disp(['Valeur de beta : ', num2str(beta_value(RMSE_y))])
disp(['----------------------------------------------Approximation par moindre carré '])


%% Correction de la fonction première itération
error = distance-F_candidat;
error_test = 0.055*sin(distance./(0.025/2.75) + pi)+0.01 ;


figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de l''exponentielle',  ['Distance (m)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test,'Courbe de l''erreur de l''approximation de l''exponentielle',  ['Distance (m)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')


%% Résultats de la correction
F_first_corr = F_candidat+error_test;
figure()
hold on
plotGraphic(distance, F_first_corr,'Courbe de l''approximation de l''exponentielle: correction 1',  ['Distance (m)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de l''exponentielle: correction 1'], ['Distance (m)'], ['Voltage (V)'])

disp(['----------------------------------------------Résultats de la correction de L''erreur '])
[RMSE_abs,RMSE_rel, R2] = error_Calculator(F_first_corr,voltage);
disp(['----------------------------------------------Résultats de la correction de L''erreur '])
legend('Courbe de l''approximation', 'Courbe des données')

%% Correction de la fonction deuxième itération
error = voltage-F_first_corr;
error_test = 0.005*sin(2*pi*distance./(0.021))+0.5.*distance ;


figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de l''exponentielle : correction 1',  ['Distance (m)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test,'Courbe de l''erreur de l''approximation de l''exponentielle : correction 1',  ['Distance (m)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')

%% Résultats de la correction
F_sec_corr = F_first_corr+error_test;

figure()
hold on
plotGraphic(distance, F_sec_corr,'Courbe de l''approximation de l''exponentielle: correction 2',  ['Distance (m)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de l''exponentielle: correction 2'], ['Distance (m)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
[~,~] = error_Calculator(F_sec_corr(100:end),voltage(200:end));
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])



%% Test distance

figure()
hold on

% distance = [0:0.0001:0.03];
% alpha = 0.01228;
% beta = 175.2223;
% F_validation = -alpha*exp(beta*distance) + voltage(end);
% F_validation = F_validation + 0.055*sin(distance./(0.025/2.75) + pi)+0.01;
% F_validation = F_validation + 0.005*sin(2*pi*distance./(0.021))+0.5.*distance;
% 
% plot(distance, F_validation);
% 
% isIncreasing = (diff(F_validation) >= 0);

















