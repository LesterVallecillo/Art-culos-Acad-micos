% Esta función selecciona la condición inicial segun el tipo de opción
% (call ó put)

function [phi0,phiedelta,payoff] = Option(nodes,Toption,strike)

switch Toption
case 'put'
payoff = max(strike-exp(nodes),0);
phi0 = strike;
phiedelta = 0;
case 'call'
payoff = max(exp(nodes)-strike,0);
phi0 = 0;
phiedelta = strike;
end
return;
payoff(1)=0; payoff(length(nodes))=0; 
end