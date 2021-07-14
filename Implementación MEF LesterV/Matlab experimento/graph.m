% Funci�n: Grafica la resoluci�n de MEF y blsprice
function graph(partition,N,strike,U,Ut,Uh,Toption)

hold on
axis('equal');
axis([0 2*strike 0 strike]);
switch Toption
case 'put'
title('Comparativo: resoluci�n de la opci�n europea venta');
case 'call'
title('Comparativo: resoluci�n de la opci�n europea compra');
end

xlabel('<--- X(precio de ejercicio) --->'), ylabel('<--- V(ganacia) --->')
plot(exp(partition),U,'g','LineWidth',2); 
plot(exp(partition),Ut,'k','LineWidth',1); 
plot(exp(partition),Uh,'b','LineWidth',1);
filename = sprintf('resolucionMEF.jpg',N);
legend('{anal�tica}','{MEF(trapecio)}','{MEF(alto orden)}');

print('-dpng',filename);

end
