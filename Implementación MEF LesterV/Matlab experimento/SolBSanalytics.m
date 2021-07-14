% Función: Evalua la solución analitica de Black-Scholes
function Sol=SolBSanalytics(partition,N,sigma,strike,r,ht,tm,tipooption)
Sol(1,N) = 0.0; % memory allocation

switch tipooption
case 'put'
for i=1:N
tau = tm-i*ht;
Sol(i) = partition(i)*normcdf((log(partition(i)/strike)+(r+(1/2)*sigma^2)*tau)/(sigma*sqrt(tau)))...
    -strike*exp(-r*tau)*normcdf((log(partition(i)/strike)...
    +(r+(1/2)*sigma^2)*tau)/(sigma*sqrt(tau))-sigma*sqrt(tau));
Sol(i) = Sol(1,i)-partition(i)+ strike*exp(-r*tau);
end
case 'call'
for i=1:N
  tau = tm-i*ht;
Sol(1,i) = partition(i)*normcdf((log(partition(i)/strike)+(r+(1/2)*sigma^2)*tau)/(sigma*sqrt(tau)))...
    -strike*exp(-r*tau)*normcdf((log(partition(i)/strike)...
    +(r+(1/2)*sigma^2)*tau)/(sigma*sqrt(tau))-sigma*sqrt(tau));
end
end
end
