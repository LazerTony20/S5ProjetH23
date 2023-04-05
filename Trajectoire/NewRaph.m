function [b,iteration] = NewRaph(a,coeffs, Lvoulu)
    q = polyint(coeffs);
    btest = 0.01;
    Lab = diff(polyval(q, [a btest]));
    dL = -polyval(coeffs, btest);
    epsilon = 10e-8;
    iteration = 0;
    while abs(Lab)  > epsilon && iteration < 501
        btest = btest + Lab/dL;
        Lab = diff(polyval(q, [a btest])) - Lvoulu;
        dL = -polyval(coeffs, btest);
        iteration = iteration +1;
    end
    iteration
    b = btest;
    Ltest = diff(polyval(q, [a btest]));
    
    
end

