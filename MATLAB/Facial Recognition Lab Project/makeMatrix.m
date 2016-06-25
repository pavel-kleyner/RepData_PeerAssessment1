function matrixOut=makeMatrix(vecIn,matrixSize)

if isnumeric(vecIn)==0
    error('A numeric vector is necessary')
end

if isvector(vecIn)&&size(vecIn,2)~=1
    warning('Original vector is not a column vector')
    vecIn=vecIn';
end

matrixOut=reshape(vecIn,matrixSize);
end