function minPos=findMinimumErrorPosition(imgVec,imageDatabase)

Pos_vector=zeros(size(imageDatabase,2),1);
for ii=1:size(imageDatabase,2)
    Pos_vector(ii)=calcMSE(imgVec,imageDatabase(:,ii));
end

%Index of the column with the lowest MSE
if min(Pos_vector)==0
    minPos=find(Pos_vector==0);
else
    minPos=find(Pos_vector==min(Pos_vector));
end

end