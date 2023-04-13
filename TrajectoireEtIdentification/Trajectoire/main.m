clear all
close all
clc

x1 = [-0.08:0.02:0.08];
x2 = [0.08:-0.02:-0.08];
x = 0:0.1:1;
y = 0:0.1:1;
y1 = (0.04^2 - (x1.^2)./4).^0.5;
y2 = 0.02*sin(2*pi*x2./0.16);

vitesse = 0.1;
Ts = 1/30;
Pdata = [x1(:) y1(:)];

[Pi, Ltr, E, Vr, traj, tt, dataSim, dDistance] = trajectoire(Pdata, vitesse, Ts);

%% Test des résultats


disp(['Valeur de l''erreur d''intégration : ', num2str(E)]);
disp(['Temp total de la trajectoire : ', num2str(tt), ' Seconde']);

figure();
hold on
plotGraphic(Ltr(:, 1), Ltr(:, 2),'Distance parcouru en fonction de la position en X',  'position X (m)', 'distance parcouru (m)')

figure()
hold on
plot(x2, y2, 'o')
xtest = dataSim(:,2);
ytest = dataSim(:,3);
plot(xtest,ytest, 'p')
plotGraphic(xtest, ytest,'Trajectoire de la bille',  'position X (m)', 'position Y (m)')

figure()
hold on
xtest = dataSim(:,1);
ytest = dataSim(:,2);
plotGraphic(xtest, ytest,'Trajectoire de la bille en X en fonction du temps',  'temps (s)', 'position X (m)')


figure()
hold on
xtest = dataSim(:,1);
ytest = dataSim(:,3);
plotGraphic(xtest, ytest,'Trajectoire de la bille en Y en fonction du temps',  'temps (s)', 'position Y (m)')




%% Validation des distances avec un code trouvé sur internet

%INPUTS – this is where you will change input data if you are doing
% a different problem
syms x;
% Define the function
curve= poly2sym(Pi);
% lower limit

% OUTPUTS
% METHOD 1. Using the calculus formula
% S=int(sqrt(1+dy/dx^2),a,b)
% finding dy/dx
poly_dif=diff(curve,x,1);
% applying the formula
bdata = traj(:, 1);
bdata = bdata(:);
integrand=sqrt(1+poly_dif^2) ;
N = size(bdata);
leng_exact = [];
for i = 2:1:N
    a=bdata(i-1);
    b=bdata(i);
    leng_exact=[leng_exact double(int(integrand,x,a,b))];
end

figure()
hold on 
M = size(leng_exact);
plotGraphic([0:1:M(2)-1], (leng_exact-dDistance)./dDistance,'Erreur sur la distance en %',  'position X (mm)', 'position Y (mm)');
