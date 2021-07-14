% Función: estima el error de MEF 
function [e1,e2]=Error(U,Ut,Uh,N)

        % Calcular el error aproximado de MEF
        u  = U(round((1/4)*N):round((3/4)*N));
        ut = Ut(round((1/4)*N):round((3/4)*N));
        uh = Uh(round((1/4)*N):round((3/4)*N));
        
        e1 = max(abs(ut-u));
        e2 = max(abs(uh-u));
       
end