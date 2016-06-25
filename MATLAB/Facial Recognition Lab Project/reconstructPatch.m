function y = reconstructPatch(A,x)

x=reshape(x,[],1);

if size(A,2)~=size(x,1)
    error('A and x are not the same dimensions')
end

y=A*x;
end