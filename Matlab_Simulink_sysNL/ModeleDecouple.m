close all
clear
clc



bancEssaiConstantes;
Valeur_Equilibre;

load("coefficients.mat")
load("donnees_prof_nl.mat")

Ck=0000;
Cik=000000;

U = [0 YB YC;
     -XA -XB -XC;
     1 1 1;];
 

Ud = inv([YD -XD 1;
      0 -XE 1;
      YF -XF 1;]);
Delta_V_phi=U(1,:)*[(VA - Va_e);(VB - Vb_e);(VC - Vc_e)];
Delta_V_theta=U(2,:)*[(VA - Va_e);(VB - Vb_e);(VC - Vc_e)];
Delta_V_z=U(3,:)*[(VA - Va_e);(VB - Vb_e);(VC - Vc_e)];
% Delta_phi
Delta_phi_A = [0 1 0;
               (Ck./Jp) 0 (Cik./Jp);
               0 0 -R./L];
Delta_phi_B = [0; 0; 1./L];
Delta_phi_C = [1 0 0];
Delta_phi_D = [0];
  
Delta_phi = ss(Delta_phi_A,Delta_phi_B,Delta_phi_C,Delta_phi_D);


Delta_theta = Delta_phi;

% Delta_z
Delta_z_A = [0 1 0;
               (Ck./m) 0 (Cik./m);
               0 0 -R./L];
Delta_z_B = Delta_phi_B;
Delta_z_C = Delta_phi_C;
Delta_z_D = Delta_phi_D;

Delta_z = ss(Delta_z_A,Delta_z_B,Delta_z_C,Delta_z_D);

% Delta_xs
Delta_xs_A = [ 0 1; 0 0];
Delta_xs_B = [0; -(ms.*g)./(ms + (Js./(Rs.^2)))];
Delta_xs_C = [1 0; 0 1];
Delta_xs_D = [0; 0];

Delta_xs = ss(Delta_xs_A,Delta_xs_B,Delta_xs_C,Delta_xs_D);

% Delta_ys
Delta_ys_A = [0 1; 0 0];
Delta_ys_B = [0; (ms.*g)./(ms + (Js./(Rs.^2)))];

Delta_ys_C = [1 0; 0 1];
Delta_ys_D = [0; 0];

Delta_ys = ss(Delta_ys_A,Delta_ys_B,Delta_ys_C,Delta_ys_D);

Delta_phi_out=lsim(Delta_phi,Delta_V_phi,tsim);
Delta_theta_out=lsim(Delta_theta,Delta_V_theta,tsim);
Delta_z_out=lsim(Delta_z,Delta_V_z,tsim);

Delta_xs_out=lsim(Delta_xs,Delta_theta_out,tsim);

Delta_ys_out=lsim(Delta_ys,Delta_phi_out,tsim);







