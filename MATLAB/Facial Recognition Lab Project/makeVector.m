function vecOut=makeVector(matrixIn)

if isnumeric(matrixIn)==0
    error('A numeric matrix is necessary')
end

if ndims(matrixIn)>2
    error('Matrix must have at most 2 dimensions')
end

vecOut=reshape(matrixIn,[],1);
end
