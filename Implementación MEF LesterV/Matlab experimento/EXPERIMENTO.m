% Experimento numérico
clear all; clc;
fprintf('..... UNIVERSIDAD NACIONAL AUTONOMA DE HONDURAS ....... \n')
fprintf('..... Carrera de Matématicas - Clase: Elemento Finto .. \n')
fprintf('..... Alumno: Lester Vallecillo -- 20093002119  ....... \n\n')

% Problema propuesto
beta=0.2;               % volativilidad o desviación estandar
r=0.05;                 % tasa de interes
strike=15;              % precio de ejercicio
tipooption='put';       % tipo de opción (compra o venta)

% Parámetros
N=100;                                       % numero de nodos
%hx=0.1;
%N=b/((hx)*deg)+1;
T=1/4;
a=0.0; b=10;                                % valores en los extremos(precio)
deg=2;                                      % grado de polinomios de aproximación

% Paso 1: Discretización
Ih=(b-a)/2;                                 % intervalo delta
hx=2*Ih/(N-1);                              % tamaño espacial
partition =[-Ih:hx:Ih]';                    % discretización espacial (precio subyacente)
ht=0.125;                                   % tamaño temporal
t=0:ht:T;                                   % discretización temporal

% Paso 2: Espacio de aproximación (funciones polinomicas y continuas por parte)

% Definir la condicion inicial del problema segun la opción (call ó put)
[phi0, phiedelta, payoff]=Option(partition,tipooption,strike);
% calcular solución análitica
[U]=SolBlsprice(partition,strike,r,T,beta,tipooption);  
% calcular solución aproximada mediante MEF con metodo del trapecio
[Solbs] = SolBSTrap(partition,N,deg,Ih,hx,ht,T,beta,r,strike,tipooption); Ut=Solbs';
% Obtener la resolución mediante MEF con alto orden
[Uh]=SolBlackS(Ih,deg,beta,r,strike,hx,ht,T,N,tipooption); 
                    
% calcular error
[eUt,eUh]=Error(U,Ut,Uh,N);

% Mostrar resolución y error
fprintf('Solución analítica: \n U(x, t)= '); disp(U);
fprintf('Resolución MEF(Trapecio): \n Ut(x, t)= '); disp(Ut);
fprintf('Error de aproximación Ut: \n Error= '); disp(eUt); 
fprintf('Resolución MEF(alto orden): \n Ub(x,t)= '); disp(Uh);
fprintf('Error de aproximación Uh: \n Error= '); disp(eUh);
Msj(eUt,eUh);

% grafiar resolución de MEF mediante método del trapecio y alto orden
graph(partition,N,strike,U,Ut,Uh,tipooption);