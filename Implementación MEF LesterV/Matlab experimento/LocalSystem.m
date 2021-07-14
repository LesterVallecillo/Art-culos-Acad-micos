% Obtener los sistemas locales de cada elemento.
function [K,M,B,b] = LocalSystem(nodesL,T,J)

n=length(nodesL);    % numero de nodos
M=zeros(n,n);  K=zeros(n,n);   B=zeros(n,n);  b=zeros(n,1);

    for i=1:n
        for j=1:n
        K(i,j)=(1/J)*integral(@(x) Dphi(x,i,nodesL).*Dphi(x,j,nodesL),0,1); % difusión
        M(i,j)= (J/6)*integral(@(x) Phi(x,i,nodesL).*Phi(x,j,nodesL),0,1);    % reacción 
        B(i,j)= integral(@(x) Dphi(x,i,nodesL).*Phi(x,j,nodesL),0,1);   % convección
        end 
        b(i)=integral(@(x) Phi(x,i,nodesL),0,1);
    end

end