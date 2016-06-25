function minErrorPos=associateImagesWithDatabase(images,correctDatabase)

minErrorPos=zeros(1,size(images,1));

for ii=1:size(images,2)
    
    minErrorPos(ii)=findMinimumErrorPosition(images(:,ii),correctDatabase);
end

end