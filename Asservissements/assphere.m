function f=assphere(num,den)
% insert num den of position tf
% returns fonctions de transfert asservie
% needs to be fedback like this:
% G=assphere(num,den);
% Gtot=feedback(G,1);

zeta=0.9;
wn=4/(2*zeta);
wn2=4/(4*zeta);
phi=acosd(zeta);


kp=(wn^2)/num;
kv=(2*zeta*wn)/(num*kp);

G=tf(num,den);
Gv=tf([kv 0],1);
GGv=feedback(G,Gv);
f=GGv*kp;


save assphere.mat kp kv



