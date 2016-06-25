function PSNR=calcPSNR(x1,x2,maxX)

if nargin<3
    maxX=1;
elseif nargin==3
    maxX=max(max(x1),max(x2));
end
     
MSE=calcMSE(x1,x2);

if MSE==0
    PSNR=100;
else
    PSNR=10*log10(maxX^2/MSE);
end
end

