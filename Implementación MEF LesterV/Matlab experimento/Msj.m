% Mensaje: metodo mas preciso

function Msj(e1,e2)
M=min([e1,e2]);
if(e1==M)
fprintf(['\n El m�todo mas preciso: ','MEF Trapecio\n']);
else
fprintf(['\n El m�todo mas preciso: ','MEF(alto orden)\n']);
end
end