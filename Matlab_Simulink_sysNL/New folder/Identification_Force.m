clear all
close all
clc

load('Fe_attraction.mat');
load('Fs.mat');

%% Moindre carrée de Fe

i = -1
be = 13.029359254409743
Fe = Fe_m1A;
z = z_m1A;
Fe_num = ((i)^2 + be*(abs(i)))*sign(i)
Y = Fe.^(-1);

X = [ones(size(z)) z z.^2 z.^3]./Fe_num;
R = X'*X;
P = X'*Y;

A = inv(R)*P;

Fe_mc = Fe_num./(A(1) + A(2).*z + A(3).*z.^2 + A(4).*z.^3)

figure();
hold on
plot(z, Fe.^-1)
plot(z,Fe_mc)
plot(z,Fe)

%% Moindre carrée de Fs

z = z_pos;


% P = [ones(size(z)) z z.^2 z.^3 z.^4 z.^5];
% A_2 = pinv(P)*Fs;
% Fs_lis = A_2(1) + A_2(2).*z + A_2(3).*z.^2 + A_2(4).*z.^3 + A_2(5).*z.^4 + A_2(6).*z.^5;
figure();
hold on
plot(z, Fs_lis)
plot(z, Fs)

Y = Fs_lis.^(-1);
X = [ones(size(z)) z z.^2 z.^3];
R = X'*X;
P = X'*Y;

A = inv(R)*P;

Fs_mc = -1./((A(1)) + A(2).*z + A(3).*z.^2 + A(4).*z.^3)

figure();
hold on
plot(z, Fs)
plot(z, Fs_mc)

