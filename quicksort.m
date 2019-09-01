function [A ord_ind] = quicksort(A, p, r, ord_ind)
% dispone in ordine crescente gli elementi del vettore x
% usando l’algoritmo "quicksort"  
%ord_ind = 1:(r-p+1); 
if p < r
        [A, q, ord_ind] = partiziona(A, p, r, ord_ind);     
        if q >= p
            [A ord_ind]= quicksort(A, p, q, ord_ind);    
            [A ord_ind]= quicksort(A, q + 1, r, ord_ind);
        end
end
 

end    