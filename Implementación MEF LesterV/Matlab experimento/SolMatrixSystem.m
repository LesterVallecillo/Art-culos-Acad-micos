% Resolver: sistema matricial global mediante la regla de cramer
function Sol=SolMatrixSystem(Mat,b,deg)
dim=length(b);
detM=det(Mat);

if(detM==0)
    fprintf(['\n Atención: el sistema es indeterminado. \n']);
    if deg==1
        [L,U] = lu(Mat);
        Sol=mldivide(U,L\b);
        else
        [L,U] = qr(Mat);
        Sol=mldivide(U,L\b);
    end
else    
    Sol=RCramer(Mat,b,dim,detM); 
end
end

function W=RCramer(Mat,b,dim,detM)
W(dim,1)=0;
for i=1:dim
Temp=Mat;
Temp(:,i)=b;
detT=det(Temp);
W(i)=detT/detM;
end
return;
end
