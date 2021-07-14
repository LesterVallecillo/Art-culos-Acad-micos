% Experimento num�rico
clear all; clc;
fprintf('..... UNIVERSIDAD NACIONAL AUTONOMA DE HONDURAS ....... \n')
fprintf('..... Carrera de Mat�maticas - Clase: Elemento Finto .. \n')
fprintf('..... Alumno: Lester Vallecillo -- 20093002119  ....... \n\n')

% Problema propuesto
beta=0.2;               % volativilidad o desviaci�n estandar
r=0.05;                 % tasa de interes
strike=15;              % precio de ejercicio
tipooption='put';       % tipo de opci�n (compra o venta)

% Par�metros
N=100;                                       % numero de nodos
%hx=0.1;
%N=b/((hx)*deg)+1;
T=1/4;
a=0.0; b=10;                                % valores en los extremos(precio)
deg=2;                                      % grado de polinomios de aproximaci�n

% Paso 1: Discretizaci�n
Ih=(b-a)/2;                                 % intervalo delta
hx=2*Ih/(N-1);                              % tama�o espacial
partition =[-Ih:hx:Ih]';                    % discretizaci�n espacial (precio subyacente)
ht=0.125;                                   % tama�o temporal
t=0:ht:T;                                   % discretizaci�n temporal

% Paso 2: Espacio de aproximaci�n (funciones polinomicas y continuas por parte)

% Definir la condicion inicial del problema segun la opci�n (call � put)
[phi0, phiedelta, payoff]=Option(partition,tipooption,strike);
% calcular soluci�n an�litica
[U]=SolBlsprice(partition,strike,r,T,beta,tipooption);  
% calcular soluci�n aproximada mediante MEF con metodo del trapecio
[Solbs] = SolBSTrap(partition,N,deg,Ih,hx,ht,T,beta,r,strike,tipooption); Ut=Solbs';
% Obtener la resoluci�n mediante MEF con alto orden
[Uh]=SolBlackS(Ih,deg,beta,r,strike,hx,ht,T,N,tipooption); 
                    
% calcular error
[eUt,eUh]=Error(U,Ut,Uh,N);

% Mostrar resoluci�n y error
fprintf('Soluci�n anal�tica: \n U(x, t)= '); disp(U);
fprintf('Resoluci�n MEF(Trapecio): \n Ut(x, t)= '); disp(Ut);
fprintf('Error de aproximaci�n Ut: \n Error= '); disp(eUt); 
fprintf('Resoluci�n MEF(alto orden): \n Ub(x,t)= '); disp(Uh);
fprintf('Error de aproximaci�n Uh: \n Error= '); disp(eUh);
Msj(eUt,eUh);

% grafiar resoluci�n de MEF mediante m�todo del trapecio y alto orden
graph(partition,N,strike,U,Ut,Uh,tipooption);