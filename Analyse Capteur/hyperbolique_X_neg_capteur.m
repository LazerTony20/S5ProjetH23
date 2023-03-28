clear all
close all
clc
load('capteur.mat')

RMSE_values = [];
F_function = [];

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

for i = 0:1:1100
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
    test = alpha./(beta-distance);
    F = voltage(end)-test;
    F_function = [F_function F];
    RMSE = sqrt(mean((F-voltage).*(F-voltage)));
    RMSE_values = [RMSE_values RMSE];
end

minimum_RMSE = min(RMSE_values);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE)
figure()
hold on
plot(distance, F_function(:,297))
plot(distance, voltage)

initial_function = F_function(:,297)

error = voltage-F_function(:,297)
RMSE_values = [];
F_function = [];
for i = 0:1:1100
    distance_test = distance; %[0.001:0.00001:0.030];
    distance_test = distance_test(1:end-i);
    error_test = error;%a.*(distance_test.^b);
    error_test = abs(error_test-error_test(end));
    error_test = error_test(1:end-i);

    y_t = error_test;
    x_t = distance_test.*error_test;
    N = size(x_t);
    N = N(1);
    X = [N sum(x_t); sum(x_t) sum(x_t.^2)];
    Y = [sum(y_t); sum(y_t.*x_t)];
    A = inv(X)*Y;

    alpha = A(1)/A(2) + 0.0009;
    beta = 1/A(2) + 0.0022;
    test = alpha./(beta-distance) ;
    F = error(end)-test+ 0.045;
    F_function = [F_function F];
    RMSE = sqrt(mean((F-voltage).*(F-voltage)));
    RMSE_values = [RMSE_values RMSE];
end

minimum_RMSE = min(RMSE_values);
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE)

figure()
hold on
plot(distance, F_function(:,73))
plot(distance, error)



F_first_corr = initial_function+F_function(:,73)
figure()
hold on
plot(distance, F_first_corr)
plot(distance, voltage)
% 
% error = voltage-F_first_corr
% error_test_2 = 0.02*sin((distance*2*pi)./(0.021)) 
% 
% figure()
% hold on
% plot(distance, error)
% plot(distance, error_test_2)
% 
% RMSE = sqrt(mean((F_first_corr-voltage).*(F_first_corr-voltage)))
% N = size(distance);
% N = N(1)
% y_moy = 1/N * sum(voltage);
% R2 = (sum((F_first_corr-y_moy).^2))/(sum((voltage-y_moy).^2))
% 
% F_sec_corr = F_first_corr+error_test_2;
% figure()
% hold on
% plot(distance, F_sec_corr)
% plot(distance, voltage)
% 
% RMSE = sqrt(mean((F_sec_corr-voltage).*(F_sec_corr-voltage)))
% N = size(distance);
% N = N(1)
% y_moy = 1/N * sum(voltage);
% R2 = (sum((F_sec_corr-y_moy).^2))/(sum((voltage-y_moy).^2))

