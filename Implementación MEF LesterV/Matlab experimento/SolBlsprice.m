% Función; calcula la solución mediante 'blsprice'
function S= SolBlsprice(partition,strike,r,tm,sigma,Toption)
[Scall, Sput] = blsprice(exp(partition), strike,r,tm,sigma);

switch Toption
case 'put'
Sol=Sput;
case 'call'
Sol=Scall;
end
S=Sol';
return;
end