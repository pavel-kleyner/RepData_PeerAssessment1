function x= solveModifiedLS(A,y)

y=reshape(y,[],1);

if size(A,1)~=size(y,1)
    error('A and y are not the same dimensions')
end



A(y==0,:)=[];
y(y==0,:)=[];

% if A==[]&&y==[]
%     x=[];
% else
x=A\y;


%end

end