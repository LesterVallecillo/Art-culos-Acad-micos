% función: ajusta las condiciones de frontera
function f= BorderCond(nodes,Ih,phi0,phiedelta,r,sigma,tau)

u_A = phi0*exp(-r*tau); 
u_B = -r*phi0*exp(-r*tau);
  f = (u_B/(2*Ih))*(nodes-Ih)+(r-(sigma^2)/2)*(1/(2*Ih))*(phiedelta-u_A) ...
-(r/(2*Ih))*((nodes+Ih)*phiedelta-(nodes-Ih)*u_A);

return;
end