function PSNRs=computePSNRs(imgVec,imageDatabase)

PSNRs=zeros(size(imageDatabase,2),1);
for ii=1:size(imageDatabase,2)
    PSNRs(ii)=calcPSNR(imgVec,imageDatabase(:,ii));
end
end
    