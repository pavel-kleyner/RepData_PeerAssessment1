function MSE=calcMSE(x1,x2)

x1=makeVector(x1);
x2=makeVector(x2);

m=size(x1,1);

mse_first_step=(x1-x2).^2;
mse_second_step=sum(mse_first_step,1);

MSE=mse_second_step/m;
end
