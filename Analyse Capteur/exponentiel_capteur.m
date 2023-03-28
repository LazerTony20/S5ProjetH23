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
    R2 = (sum((F-y_moy).^2))/(sum((voltage-y_moy).^2));
    R2_value = [R2_value R2];
end

minimum_RMSE = min(RMSE_values);
R2_find = (abs(R2_value-1));
best_R2 = min(abs(R2_value-1));
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE);
[R2_x,R2_y] = find(R2_find == best_R2);

figure()
hold on
plot(distance, voltage)
plot(distance, F_function(:,11));


error = voltage-F_function(:,11);
error_test = 0.055*sin(distance./(0.025/2.75) + pi)+0.01 ;

figure()
hold on
plot(distance, error)
plot(distance, error_test)

F_first_corr = F_function(:,11)+error_test;
figure()
hold on
plot(distance, F_first_corr)
plot(distance, voltage)

RMSE = sqrt(mean((F_first_corr-voltage).*(F_first_corr-voltage)))
N = size(distance);
N = N(1)
y_moy = 1/N * sum(voltage);
R2 = (sum((F_first_corr-y_moy).^2))/(sum((voltage-y_moy).^2))















