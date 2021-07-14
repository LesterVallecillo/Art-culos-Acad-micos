% función: evalua la funciones base en el punto x

function phi=Phi(x,i,nodes)
phi=ones(size(x));
    for j=1:i-1
        phi=phi.*(x-nodes(j))/(nodes(i)-nodes(j));
    end
    
    for j=i+1:length(nodes)
        phi = phi.*(x-nodes(j))/(nodes(i)-nodes(j));
    end
end
