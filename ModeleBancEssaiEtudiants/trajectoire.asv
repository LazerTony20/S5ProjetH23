function [Pi, Ltr, E, Vr, traj, tt, dataSim, dDistance] = trajectoire(Pdata, vab, Ts)
    xdata = Pdata(:,1);
    ydata = Pdata(:,2);

    [coef, parcours, RMSEa, RMSEr, R2] = interpolation(xdata, ydata, size(xdata)-1);
    [g,Mxdata,h, L, Lx, E] = calc_longueur(xdata(1), xdata(end), coef, 100);

    Vr = (L/floor((L/vab)/Ts))/Ts;
    dDistance = Vr*Ts;
    tt = L/Vr;
    bdata = [xdata(1)];
    a = xdata(1);
    while abs(a) <= abs(xdata(end))  
        [b, i] = NewRaphV2(a,h, coef, dDistance);
        bdata = [bdata b];
        a = b;
    end
    xParcours = bdata(:);
    temp = polyval(coef, bdata);
    yPacours = temp(:);

    Pi = coef;
    Ltr = [Mxdata(:) Lx(:)];
    E = E;
    Vr = Vr;
    traj = [xParcours yPacours];
    temp = [0:Ts:tt];
    dataSim = [temp(:) traj(:,1) traj(:, 2)];

end

