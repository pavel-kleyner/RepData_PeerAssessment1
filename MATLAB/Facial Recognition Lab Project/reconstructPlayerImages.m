function [reconstructedImages, PSNRs]= reconstructPlayerImages(corruptedImages,dictionary,blockSize,origImage)

[R,pivots]=rref(dictionary);

dictionary=dictionary(:,pivots);

dictionary=[ones(size(dictionary,1)) dictionary];

reconstructedImages=zeros(size(corruptedImages));

PSNRs=zeros(size(corruptedImages,1),1);

for ii=1:size(corruptedImages,2)
    corrupt_image=makeMatrix(corruptedImages(:,ii),size(origImage));
    
    constructed_image=reconstructImage(corrupt_image,dictionary,blockSize);
    
    reconstructedImages(:,ii)=constructed_image;
    
end

PSNRs=computePSNRs(origImage,reconstructedImages);

end