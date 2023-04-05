function [b,iteration] = NewRaphV2(a,h,coeffs, Lvoulu)
    btest = a+h;
    [~, ~,~,  Lab, ~] = calc_longueur(a,btest,coeffs, 100);
    Lab = Lab-Lvoulu;
    dL = -sqrt(1+polyval(polyder(coeffs), btest)^2);
    epsilon = 1e-6;
    iteration = 0;
    while abs(Lab)  > epsilon && iteration < 501
        btest = btest + Lab/dL;
        [~, ~,~,  Lab, ~] = calc_longueur(a,btest,coeffs, 100);
        Lab =  Lab-Lvoulu;
        dL = -sqrt(1+polyval(polyder(coeffs), btest)^2)*sign(h);
        iteration = iteration +1;
    end
    iteration
    b = btest;
end