clear all
close all
clc
load('capteur.mat')
RMSE_values = [];
R2_value = [];
F_function = [];
alpha_value = [];
beta_value = [];
for i = 0:1:1000
    removed_value = i;
    V = voltage(1:end-removed_value);
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
R2_find = (abs(R2_value-1))
best_R2 = min(abs(R2_value-1));
[RMSE_x,RMSE_y] = find(RMSE_values == minimum_RMSE)
[R2_x,R2_y] = find(R2_find == best_R2)

figure()
hold on
plot(distance, voltage)
plot(distance, F_function(:,11));

tic
test = alpha_value(11)*exp(beta_value(11)*distance);
F = -test+voltage(end);
toc

% figure()
% hold on
% plot(distance, voltage-F_function(:,11));
%error = voltage-F_function(:,11)

X = [];
Y = [];
for i=0:1:4
    X_line = [];
    for j=0:1:4
        X_line = [X_line sum(distance.^(i+j))];
    end
    X = [X; X_line];
    Y = [Y; sum((distance.^i).*voltage)];
end 

A = inv(X)*Y;

tic
test2 = A(1) + A(2).*distance + A(3).*distance.^2 + A(4).*distance.^3 + A(5).*distance.^4;% + A(6).*distance.^5 + A(7).*distance.^6 + A(8).*distance.^7;
toc

F2 = F_function(:,11) + test2;
figure()
hold on
plot(distance, voltage)
plot(distance, test2)
%  RMSE = sqrt(mean((F2-voltage).*(F2-voltage)));









