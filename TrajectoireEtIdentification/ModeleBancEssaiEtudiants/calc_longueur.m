function [g, Mxdata,h,  L, Lx, E] = calc_longueur(a, b,coefficients, Mn)
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

    f_b = polyval(conv(polyder(coefficients), polyder(dcoeff)), b)/sqrt(1+polyval(dcoeff,b).^2);
    f_a = polyval(conv(polyder(coefficients), polyder(dcoeff)), a)/(sqrt(1+polyval(dcoeff,a).^2));
    E = ((h^2)/12)*(f_b-f_a);
   
end