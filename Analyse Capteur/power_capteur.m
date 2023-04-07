clear all
close all
clc
load('capteur.mat')

RMSE_values = [];
R2_value = [];
F_function = [];
alpha_value = [];
beta_value = [];

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

for i = 0:1:1120
    distance_test = distance; %[0.001:0.00001:0.030];
    distance_test = distance_test(1:end-i);
    voltage_test = voltage;%a.*(distance_test.^b);
    voltage_test = abs(voltage_test-voltage_test(end));
    voltage_test = voltage_test(1:end-i);

    y_t = log(voltage_test);
    x_t = log(distance_test);
    N = size(x_t);
    N = N(1);
    X = [N sum(x_t); sum(x_t) sum(x_t.^2)];
    Y = [sum(y_t); sum(y_t.*x_t)];
    A = inv(X)*Y;

    alpha = exp(A(1));
    alpha_value = [alpha_value alpha];
    beta = A(2);
    beta_value = [beta_value beta];
    test = alpha.*(distance.^(beta));
    F = voltage(end)-test;
    F_function = [F_function F];
    RMSE = sqrt(mean((F-voltage).*(F-voltage)));
    RMSE_values = [RMSE_values RMSE];
end


minimum_RMSE = min(RMSE_values);
best_R2 = max(R2_value);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);
[R2_x,R2_y] = find(R2_value == best_R2);

F_candidat =  F_function(:,RMSE_y);

figure()
hold on
plotGraphic(distance, F_candidat,'Courbe de l''approximation de la puissance',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage,'Courbe de l''approximation de la puissance',  ['Distance (mm)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Approximation par moindre carré '])
[~, ~] = error_Calculator(F_candidat, voltage)
disp(['Valeur de alpha :', num2str(alpha_value(RMSE_y))]);
disp(['Valeur de beta : ', num2str(beta_value(RMSE_y))])
disp(['----------------------------------------------Approximation par moindre carré '])

%% Correction de l'erreur
error = voltage-F_candidat;
error_test = 0.1*sin(137.0968.*distance + pi-0.30) ;

figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de la puissance',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test,'Courbe de l''erreur de l''approximation de la puissance',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')


%% Résultats de la première correction d'erreur
F_first_corr = F_candidat+error_test;
figure()
hold on
plotGraphic(distance, F_first_corr,'Courbe de l''approximation de la puissance: correction 1',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de la puissance: correction 1'], ['Distance (mm)'], ['Voltage (V)'])

disp(['----------------------------------------------Résultats de la correction de L''erreur '])
[RMSE_abs,RMSE_rel, R2] = error_Calculator(F_first_corr,voltage);
disp(['----------------------------------------------Résultats de la correction de L''erreur '])
legend('Courbe de l''approximation', 'Courbe des données')


%% approcimation de l'erreur deuxieme fois
error = voltage-F_first_corr;
error_test_2 = (2.5.*distance)+0.014*sin((distance*2*pi)./(0.023))-0.030;


figure()
hold on
hold on
plotGraphic(distance, error,'Courbe de l''erreur de l''approximation de la puissance : correction 1',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, error_test_2,'Courbe de l''erreur de l''approximation de la puissance : correction 1',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')


%% Résultat de la deuxième correction d'erreur
F_sec_corr = F_first_corr+error_test_2;

figure()
hold on
plotGraphic(distance, F_sec_corr,'Courbe de l''approximation de la puissance correction 2',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage, ['Courbe de l''approximation de la puissance: correction 2'], ['Distance (mm)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
[~,~] = error_Calculator(F_sec_corr(300:end),voltage(300:end));
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
