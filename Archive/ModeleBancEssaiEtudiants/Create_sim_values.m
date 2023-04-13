%% Rouler Simulation du prof
clear all
clc
close all

run_bancessai
Ax = ynonlineaire(:,1);
Ay= ynonlineaire(:,2);
Pz= ynonlineaire(:,3);
Wx= ynonlineaire(:,4);
Wy= ynonlineaire(:,5);
Vz= ynonlineaire(:,6);
Px= ynonlineaire(:,7);
Py= ynonlineaire(:,8);
Vx= ynonlineaire(:,9);
Vy= ynonlineaire(:,10);
IA= ynonlineaire(:,11);
IB= ynonlineaire(:,12);
IC= ynonlineaire(:,13);
zA= ynonlineaire(:,14);
zB= ynonlineaire(:,15);
zC= ynonlineaire(:,16);
zD= ynonlineaire(:,17);
zE= ynonlineaire(:,18);
zF= ynonlineaire(:,19);
FA= ynonlineaire(:,20);
FB= ynonlineaire(:,21);
FC= ynonlineaire(:,22);
VA= ynonlineaire(:,23);
VB= ynonlineaire(:,24);
VC= ynonlineaire(:,25);

save donnee_sim_prof.mat tsim Ax Ay Pz Wx Wy Vz Px Py Vx Vy IA IB IC zA zB zC zD zE zF FA FB FC VA VB VC