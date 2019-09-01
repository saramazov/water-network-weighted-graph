function [cammino,residuo] = find_path(R)                                   % find_path: dato il grafo residuo R, cerco un cammino aumentante
                                                                            % e la quantità di flusso inviabile su quel cammino
[d,f,p,t] = DFS(R);                                                         % DFS: visita DFS del grafo R

n=R.get_size();

cammino(1)=n;                                                               % cammino: in prima posizione c'è il pozzo (ultimo nodo, indice n)
capacita(1)=Inf;                                                            % Capacità contiene la minima capacità del percorso: per il pozzo è infinita
appo=n;                                                                     % appo: variabile d'appoggio. Inizialmente è il pozzo
cont=1;                                                                     % contatore: inizializzato a 1

while appo~=(n-1)                                                           % Il ciclo viene eseguito finchè appo non coincide con l'acquedotto (nodo n-1)
    if p(appo)~=0                                                           % Se il predecessore del nodo non è 0 (ovvero, se il nodo ha un predecessore): 
       cont=cont+1;                                                         % incremento il contatore di 1
       cammino(cont)= p(appo);                                              % memorizzo in cammino, in posizione cont, il predecessore del nodo
       appo = p(appo);                                                      % il nuovo nodo diventa il padre
       capacita(cont)=t(appo);                                              % in capacita memorizzo il valore di t per il nodo appo
    else
        disp('Eureka! Siamo arrivati al massimo flusso');                   % Se invece appo non ha un predecessore, allora il cammino è interrotto:
        residuo=0;                                                          % ho ottenuto un taglio s-t del grafo, e quindi il massimo flusso.
        break;                                                              % esco allora dal ciclo, ponendo residuo=0 (non c'è ulteriore flusso da inviare)
    end
end



copia=cammino;                                                              
if cammino(cont)==(n-1)                                                     % Se il cammino ha raggiunto l'acquedotto (n-1), allora:   
   for i=1:cont                                                             % ribalto il cammino sfruttando una copia: ottengo così come punto di partenza
        cammino(i)=copia(cont+1-i);                                         % l'acquedotto, e come arrivo il pozzo. 
   end
    residuo=min(capacita);                                                  % in residuo memorizzo il minimo del vettore capacita: minimo tra le capacita
end                                                                         % degli archi del percorso


end