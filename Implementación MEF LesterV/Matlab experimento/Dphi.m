% función: evalua la derivada de las funciones base en el punto x

function dphi=Dphi(x,i,nodes)
dphi=ones(size(x));
    for j=1:i-1
        dphi=dphi.*(-1.0/(nodes(i)-nodes(j)));
    end;
    
    for j=i+1:length(nodes)
        dphi=dphi.*(1.0/(nodes(i)-nodes(j)));
    end

