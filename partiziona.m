function [x part ord]= partiziona(x, p, r, ord)
% esegue una partizione del vettore x
% ord corrisponde agli indici della permutazione
% considerando come pivot il primo elemento di x
part = p-1;
c = x(p);
i = p; j = r;
while 1            
    while x(i) < c
        i = i+1;
    end
    while x(j) > c
      j = j-1;
    end
    if i < j
        w = x(i); x(i) = x(j); x(j) = w; %scambio gli elementi
        w2 = ord(i); ord(i) = ord(j); ord(j) = w2; % scambio gli indici
        i = i+1; j = j-1;        
    else
       part=j;
       break;
    end   
end

end

