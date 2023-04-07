function [coefficients, data, RMSE_abs, RMSE_rel, R2] = interpolation(xdata, ydata, nbcoefficients)
    X = [];
    Y = [];
    for i=0:1:nbcoefficients
        X_line = [];
        for j=0:1:nbcoefficients
            X_line = [X_line sum(xdata.^(i+j))];
        end
        X = [X; X_line];
        Y = [Y; sum((xdata.^i).*ydata)];
    end 

    coefficients = inv(X)*Y;
    coefficients = coefficients(end:-1:1);
    data = polyval(coefficients, xdata);
    
    RMSE_abs = sqrt(mean((data-ydata).^2));
    RMSE_rel = sqrt(mean(((data-ydata)/ydata).^2));
    ymoy = mean(ydata);
    R2 = 1-(sum((data-ydata).^2))/(sum((data-ymoy).^2));
    
end

