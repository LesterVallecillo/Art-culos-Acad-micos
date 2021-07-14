function [Vh] = SolBlackS(Ih,deg,sigma,r,strike,hx,ht,tm,N,Toption)
n=(N-1)*deg+1;
h=(2*Ih)/(n-1);
nodes=[-Ih:h:Ih]';
[phi0,phiedelta,payoff]=Option(nodes,Toption,strike);

% iniciar vector solución(cond iniciales)
w = payoff;
w(2:(end-1)) = payoff(2:(end-1))-(((nodes(2:(end-1))+Ih)/(2*Ih))*phiedelta-(((nodes(2:(end-1))-Ih)/(2*Ih))*phi0));
w(1)=hx/6;  w(end)=hx/6;
% obtener el sistema global
[SystemG,M] = GlobalSystem(nodes,N,deg,sigma,r);
A=M;
A(1,:)=0;   A(:,1)=0;       A(1,1)=(hx/6);
A(n,:)=0;   A(:,n)=0;       A(n,n)=(hx/6);

% sistema de formulación variacional.
Mat=M+(ht/2)*SystemG;

% ajustar condiciones de frontera en cada paso
for tau=0:ht:(tm-ht)
    F= A*(BorderCond(nodes,Ih,phi0,phiedelta,r,sigma,tau)...
      + BorderCond(nodes,Ih,phi0,phiedelta,r,sigma,tau+ht));
    b=(M-(ht/2)*SystemG)*w+(ht/2)*F; 
    w=SolMatrixSystem(Mat,b,deg);
end; 

% Resolución del problema
V =w+(((nodes+Ih)/(2*Ih))*phiedelta-(((nodes-Ih)/(2*Ih))*phi0*exp(-r*tm)));
for i=1:N
Uh(i)=V(deg*i-(deg-1));
end
Vh=abs(Uh);

return;
end