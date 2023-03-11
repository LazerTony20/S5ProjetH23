load("coefficients.mat")

g   = 9.81;

z_range  = 22.2e-03;            % m
zr_comb = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1]'*z_range;

%Valeur de la bille (true of false)
sig = 1;

% Distance 2D du centre des aimants de sustentation au centre de la plaque
rABC = 95.20e-03;     % m

% Course maximale en angle
A_range = (z_range/rABC)/(2*sqrt(2));

% Coordonnées des aimants
XA = +rABC;
YA =  0.0;
ZA =  0.0;
XB = -rABC*sind(30);
YB = +rABC*cosd(30);
ZB =  0.0;
XC = -rABC*sind(30);
YC = -rABC*cosd(30);
ZC =  0.0;

xvec_ABC = [XA, XB, XC]';
yvec_ABC = [YA, YB, YC]';

TABC = [yvec_ABC'; -xvec_ABC'; ones(1,3)];
TABC_inv = inv(TABC);

ptz_comb = TABC_inv' * zr_comb;
ptz_range = max(ptz_comb,[],2);

% Distance 2D du centre des aimants effet Hall au centre de la plaque
rDEF = 80.00e-03;     % m

% Coordonnées des capteurs à effet Hall
% Données mises à jour le 10 mai 2015
XD = +rDEF*sind(30);
YD = +rDEF*cosd(30);
ZD =  0.0;
XE = -rDEF;
YE =  0.0;
ZE =  0.0;
XF = +rDEF*sind(30);
YF = -rDEF*cosd(30);
ZF =  0.0;

xvec_DEF = [XD, XE, XF]';
yvec_DEF = [YD, YE, YF]';

TDEF = [yvec_DEF'; -xvec_DEF'; ones(1,3)];
TDEF_inv = inv(TDEF);

% Paramètres inertiels
% --------------------

% Données mises à jour le 10 juillet 2015
% Sphère
masseS = 0.0080;           % kg
rS = 0.0039;           % m
inertie_sphere = 2*masseS*rS^2/5;     % solid kg m^2
% inertie_sphere = 2*masseS*rS^2/3;     % hollow

% Paramètres dérivés de la sphère
masseSeff = masseS+inertie_sphere/rS^2;   % kg - masse effective de la sphère
Fg_sphere   = masseS*g;         % N - poids de la sphère

% Plaque
masseP = 425e-03;     % kg
inertiePx =  1.347*10^-3;  % kg m^2
inertiePy =  inertiePx;             % kg m^2
inertieP =  inertiePx;
Jz = 2329e-06;  % kg m^2
masseTotal = masseP + sig*masseS;   % kg - mase totale plaque + sphère
Fg_total = masseTotal*g;

% Simulation
Vmax = 16.0;

% Paramètres électriques des actionneurs
% Données mises à jour le 10 juillet 2015
RR = 3.6;
LL = .115;
RA =  RR;
LA =  LL;
RB =  RR;
LB =  LL;
RC =  RR;
LC =  LL;


%%%%%%%%%%%%%%%%
%Cette section contiendra les calculs afin de déteminer la valeur des
%paramètres des force. Pour le moment, des valeurs temporaires sont mises

ae0 = A_fe(1);
ae1 = A_fe(2);
ae2 = A_fe(3);
ae3 = A_fe(4);

as0 = A_fs(1);
as1 = A_fs(2);
as2 = A_fs(3);
as3 = A_fs(4);
%%%%%%%%%%%%%%%%


poly_ae = [ae3 ae2 ae1 ae0];
poly_as = [as3 as2 as1 as0];
num = -1; %Numérateur de Fsk
be = 13.029359254409743; %Valeur de Be