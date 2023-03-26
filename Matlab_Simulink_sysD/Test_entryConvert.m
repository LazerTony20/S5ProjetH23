clear all
load('donnees_prof_nl.mat')
Constante_L

U = [0 YB YC;
    -XA -XB -XC;
    1 1 1];

U_inv = inv(U);

VA_sim = timeseries(VA, tsim);
VB_sim = timeseries(VB, tsim);
VC_sim = timeseries(VC, tsim);

simout = sim('Test_convertEntry')