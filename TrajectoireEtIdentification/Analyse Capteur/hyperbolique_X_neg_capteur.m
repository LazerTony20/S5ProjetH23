clear all
close all
clc
load('capteur.mat')

RMSE_values = [];
F_function = [];
alpha_value = [];
beta_value = [];
R2_value = [];

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

for i = 297:1:297
    distance_test = distance; %[0.001:0.00001:0.030];
    distance_test = distance_test(1:end-i);
    voltage_test = voltage;%a.*(distance_test.^b);
    voltage_test = abs(voltage_test-voltage_test(end));
    voltage_test = voltage_test(1:end-i);

    y_t = voltage_test;
    x_t = distance_test.*voltage_test;
    N = size(x_t);
    N = N(1);
    X = [N sum(x_t); sum(x_t) sum(x_t.^2)];
    Y = [sum(y_t); sum(y_t.*x_t)];
    A = inv(X)*Y;

    alpha = A(1)/A(2);
    beta = 1/A(2);
    alpha_value = [alpha_value alpha];
    beta_value = [beta_value beta];
    test = alpha./(beta-distance);
    F = voltage(end)-test;
    F_function = [F_function F];
    RMSE = sqrt(mean(((F-voltage)./voltage).^2));
    RMSE_values = [RMSE_values RMSE];
    y_moy = mean(voltage);
    R2 = 1-(sum((F-voltage).^2))/(sum((voltage-y_moy).^2));
    R2_value = [R2_value R2];
end

minimum_RMSE = min(RMSE_values);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);

F_candidat =  F_function(:,RMSE_y);
figure()
hold on
plotGraphic(distance, F_candidat,'Courbe de l''approximation de l''hyperbolique',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage,'Courbe de l''approximation de l''hyperbolique',  ['Distance (mm)'], ['Voltage (V)'])
legend('Courbe de l''approximation', 'Courbe des données')
disp(['----------------------------------------------Approximation par moindre carré '])
[~, ~] = error_Calculator(F_candidat, voltage)
disp(['Valeur de alpha :', num2str(alpha_value(RMSE_y))]);
disp(['Valeur de beta : ', num2str(beta_value(RMSE_y))])
disp(['----------------------------------------------Approximation par moindre carré '])


%% Correction de l'erreur
error = voltage-F_candidat;
RMSE_values = [];
Error_function = [];
alpha_value = [];
beta_value = [];
R2_value = [];

for i = 0:1:1110
    distance_test = distance;
    distance_test = distance_test(1:end-i);
    error_test = error;
    error_test = abs(error_test-error_test(end));
    error_test = error_test(1:end-i);

    y_t = error_test;
    x_t = distance_test.*error_test;
    N = size(x_t);
    N = N(1);
    X = [N sum(x_t); sum(x_t) sum(x_t.^2)];
    Y = [sum(y_t); sum(y_t.*x_t)];
    A = inv(X)*Y;

    alpha = A(1)/A(2);
    beta = 1/A(2);
    alpha_value = [alpha_value alpha];
    beta_value = [beta_value beta];
    test = alpha./(beta-distance);
    F = error(end)-test;
    Error_function = [Error_function F];
    RMSE = sqrt(mean(((F-error)./error).^2));
    RMSE_values = [RMSE_values RMSE];
    y_moy = mean(error);
    R2 = 1-(sum((F-error).^2))/(sum((error-y_moy).^2));
    R2_value = [R2_value R2];
end

minimum_RMSE = min(RMSE_values);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);


F_error = Error_function(:,RMSE_y);
figure()
hold on
plotGraphic(distance, error,'Courbe de l''erreur approximé de l''hyperbolique',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
plotGraphic(distance, F_error,'Courbe de l''erreur approximé de l''hyperbolique',  ['Distance (mm)'], ['\DeltaVoltage (V)'])
disp(['----------------------------------------------Paramètre de la fonction de correction d''erreur '])
[~, ~] = error_Calculator(F_candidat, voltage)
disp(['Valeur de alpha :', num2str(alpha_value(RMSE_y))]);
disp(['Valeur de beta : ', num2str(beta_value(RMSE_y))])
disp(['----------------------------------------------Paramètre de la fonction de correction d''erreur'])
legend('Courbe de l''erreur', 'Courbe de la correction d''erreur')

%% Résultat dela première correction
F_first_corr = F_candidat+F_error;

figure()
hold on
plotGraphic(distance, F_first_corr,'Courbe de l''approximation de l''hyperbolique: Correction 1',  ['Distance (mm)'], ['Voltage (V)'])
plotGraphic(distance, voltage,'Courbe de l''approximation de l''hyperbolique: Correction 1',  ['Distance (mm)'], ['Voltage (V)'])

disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])
[~, ~] = error_Calculator(F_first_corr(300:end), voltage(300:end))
disp(['----------------------------------------------Résultats de la correction de L''erreur, deuxième itération '])





