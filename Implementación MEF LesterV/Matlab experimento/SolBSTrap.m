function [V] = SolBSTrap(particion,N,deg,Ih,hx,ht,tm,sigma,r,strike,opcion)
%La funcion BSeuropea aproxima el valor de una opcion europea mediante MEF

% Establecer las condiciones iniciales, segun la opcion (call ó put)
[phi0,phiedelta,payoff] = Option(particion,opcion,strike);

% Siatema matricial global deducido mediante el metodo del trapecio.
M = (hx/6)*(gallery('tridiag',N,1,4,1));
K = (1/hx)*(gallery('tridiag' ,N,-1,2,-1));
B = (gallery('tridiag',N,-1/2,0,1/2));
A = M;
A(1,:)=0;   A(:,1)=0;    A(1,1)=hx/6;
A(N,:)=0;   A(:,N)=0;    A(N,N)=hx/6;
R = ((sigma^2)/2)*K+(((sigma^2)/2)-r)*B +r*M;

% Iniciar la función solución que cuantifica las ganancias
u = payoff-(((particion+Ih)/(2*Ih))*phiedelta...
    -(((particion-Ih)/(2*Ih))*phi0));
Mat=M+(ht/2)*R;

% Ajustar las condiciones de frontera
for itau = 0:ht:(tm-ht)
F = A*(BorderCond(particion,Ih,phi0,phiedelta,r,sigma,itau)...
+BorderCond(particion, Ih, phi0,phiedelta,r,sigma,itau+ht));
b =(M-(ht/2)*R)*u+(ht/2)*(F);
u = SolMatrixSystem(Mat,b,deg);
end

% Obtener la solución general
V = u+(((particion+Ih)/(2*Ih))*phiedelta-(((particion-Ih)/(2*Ih))*phi0*exp(-r*tm)));

return;
end
