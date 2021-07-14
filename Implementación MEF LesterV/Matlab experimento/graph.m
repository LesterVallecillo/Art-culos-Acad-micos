% Función: Grafica la resolución de MEF y blsprice
function graph(partition,N,strike,U,Ut,Uh,Toption)

hold on
axis('equal');
axis([0 2*strike 0 strike]);
switch Toption
case 'put'
title('Comparativo: resolución de la opción europea venta');
case 'call'
title('Comparativo: resolución de la opción europea compra');
end

xlabel('<--- X(precio de ejercicio) --->'), ylabel('<--- V(ganacia) --->')
plot(exp(partition),U,'g','LineWidth',2); 
plot(exp(partition),Ut,'k','LineWidth',1); 
plot(exp(partition),Uh,'b','LineWidth',1);
filename = sprintf('resolucionMEF.jpg',N);
legend('{analítica}','{MEF(trapecio)}','{MEF(alto orden)}');

print('-dpng',filename);

end
