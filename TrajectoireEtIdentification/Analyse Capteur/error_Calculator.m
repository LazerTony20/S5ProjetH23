function [RMSE_abs,RMSE_rel, R2] = error_Calculator(Yapprox,Yvoulu)
    RMSE_abs = sqrt(mean((Yapprox-Yvoulu).^2));
    RMSE_rel = sqrt(mean(((Yapprox-Yvoulu)./Yvoulu).^2));
    y_moy =mean(Yvoulu);
    R2 = 1-(sum((Yapprox-Yvoulu).^2))/(sum((Yvoulu-y_moy).^2));

    disp(['--------------------------Erreur'])
    disp(['RMSE absolu : ', num2str(RMSE_abs)])
    disp(['RMSE relative : ',num2str(RMSE_rel)])
    disp(['R2 réel: ',num2str(R2)])
     disp(['--------------------------Erreur'])
     disp([''])
end