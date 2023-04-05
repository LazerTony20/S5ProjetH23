function [g, Mxdata,h,  L, Lx] = calc_longueur(a, b,coefficients, Mn)
    h = (b-a)/Mn;
    Mxdata = [a: h:b];
    dcoeff = polyder(coefficients);
    ddata = polyval(dcoeff, Mxdata);
    g = sqrt(1+ddata.^2);
    L = (g(1)+g(end)+2*sum(g(2:end-1)))*(abs(h)/2);
    
    Lx(1) = 0;
    for n = 2:Mn+1
        Lx(n) = (g(1)+g(n)+2*sum(g(2:n-1)))*(abs(h)/2);
    end
   
end