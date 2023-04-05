clear all
close all
clc

x1 = [-0.08:0.001:0.08];
x2 = [0.08:-0.001:-0.08];
y1 = (0.04^2 - (x1.^2)./4).^0.5;
y2 = 0.02*sin(2*pi*x2./0.16);

vitesse = 0.1;



[coef2, parcours2, RMSEa2, RMSEr2, R22] = interpolation(x2, y2, 5);
[g,Mxdata,h, L, Lx] = calc_longueur(x2(1), x2(end), coef2, 100);


bdata = [];
a = x2(1);
while abs(a) <= abs(x2(end))  
    [b, i] = NewRaphV2(a,h, coef2, 0.02);
    bdata = [bdata b];
    a = b;
end


%% Validation des distances avec un code trouvé sur internet

%INPUTS – this is where you will change input data if you are doing
% a different problem
syms x;
% Define the function
curve= poly2sym(coef2);
% lower limit

% OUTPUTS
% METHOD 1. Using the calculus formula
% S=int(sqrt(1+dy/dx^2),a,b)
% finding dy/dx
poly_dif=diff(curve,x,1);
% applying the formula
integrand=sqrt(1+poly_dif^2);
N = size(bdata)
N = N(2);
for i = 2:1:N
    a=bdata(i-1);
    b=bdata(i);
    leng_exact=double(int(integrand,x,a,b))
end
