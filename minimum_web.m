function [G,T,cont] = minimum_web(G,cont,abitazione,indirizzo)              % minimum_web: trovo la rete idrica con peso totale degli archi minimo.

n=G.get_size();                                                                 
m=n;

while m==n                                                                  % Chiedo all'utente le coordinate dell'acquedotto:  
u=input('Inserisci coordinata x dell''acquedotto: ');                       % se le coordinate sono già presenti nel grafo, non viene aggiunto.
v=input('Inserisci coordinata y dell''acquedotto: ');                       % In tal caso viene chiesto all'utente di reinserire le coordinate.
address='acquedotto';                                                       % Quando l'acquedotto viene aggiunto correttamente, viene memorizzato
                                                                            % in ultima posizione nel grafo, con indirizzo "acquedotto".
G.add_node(n+1,u,v,address);
m=G.get_size();
end

for i=1:n                                                                   % Aggiungo gli archi tra tutte le abitazioni e l'acquedotto, 
    peso=sqrt((abitazione(i,1)-u).^2+(abitazione(i,2)-v).^2);               % il cui indice è n+1
    G.add_edge(i,n+1,peso);
end


T=kruskal(G);                                                               % L'algoritmo kruskal trova la rete minima: restituisce T, ovvero
                                                                            % la lista degli archi che costituiscono la rete minima. 

G=build_graph_no_edge(abitazione,indirizzo);                                % Ricostruisco il grafo G, con gli stessi nodi ma senza archi 


G.add_node(n+1,u,v,address);                                                % Aggiungo l'acquedotto al grafo

abitazione=[abitazione;u,v];                                                % Aggiorno temporaneamente abitazione (è utile per l'operazione successiva)

 for j=1:length(T)                                                          % Aggiungo gli archi contenuti nella lista T al grafo
        appo1=T(j).nodo1;                                                   % Il numero di archi è pari a size(G)-1, poichè ogni casa ha un solo 
        appo2=T(j).nodo2;                                                   % arco in entrata, escluso l'acquedotto.
        appo=sqrt((abitazione(appo1,1)-abitazione(appo2,1)).^2+(abitazione(appo1,2)-abitazione(appo2,2)).^2);                                 
        G.add_edge(appo1,appo2,appo);          
 end                                                                        


abitazione(n+1,:)=[];                                                       % Cancello l'ultima riga di abitazione
cont=cont+1;                                                                % Incremento il contatore ad ogni esecuzione della funzione.

end