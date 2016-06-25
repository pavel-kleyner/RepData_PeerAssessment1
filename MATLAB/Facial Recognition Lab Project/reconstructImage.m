function y = reconstructImage(img,dictionary,blockSize)

if prod(blockSize)~=size(dictionary,1)
    error('blockSize is not consistent with dictionary size')
end

col2nd_img=zeros(size(img));
matrix_initial=nd2col(img,blockSize,'sliding');
matrix_final=zeros(size(matrix_initial));

for ii=1:size(matrix_initial,2)
    least_squares_soln=solveModifiedLS(dictionary,matrix_initial(:,ii));
    
    matrix_final(:,ii)=reconstructPatch(dictionary,least_squares_soln);
    
    
    
end
    col2nd_img=col2nd(matrix_final,blockSize,size(img),'sliding');
    
    y=makeVector(col2nd_img);

end

