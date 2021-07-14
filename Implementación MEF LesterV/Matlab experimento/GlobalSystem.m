% función: emsambla los sistemas locales
function [SystemG,M]=GlobalSystem(partition,N,deg,sigma,r)
n=(N-1)*deg+1;
K=zeros(n); M=zeros(n); B=zeros(n); b=zeros(n,1);
localNodes=0:1/deg:1;                           % elemento arbitrario de referencia

for k=1:N-1                                     % ensamble
    J=(k-1)*(deg)+1;                            % indice de cada elementos
     L=J:J+deg;                                 % areglo de indices 
    Jk=(partition(k+1)-partition(k));           % Jacobiano de cada elemento
    T=@(x) partition(k+1)*x+partition(k)*(1-x); % tranformada de elemento de referencia
    [Kk,Mk,Bk,bk]= LocalSystem(localNodes,T,Jk); 
    K(L,L)=K(L,L)+Kk;                           % ensambla la matriz de difusión
    M(L,L)=M(L,L)+Mk;                           % ensambla la matriz de racción
    B(L,L)=B(L,L)+Bk;                           % ensambla la matriz de convección
    b(L)= b(L)+bk;                              % ensambla el vector de carga
end
% sistema de forma explicita
SystemG=((sigma^2)/2)*K+(((sigma^2)/2)-r)*B+r*M;
return;
end