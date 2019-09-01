function G=build_graph(abitazione,indirizzo)                                % build_graph: costruisco il grafo iniziale. Tutte le case saranno collegate
disp('Inizializzazione del grafo: il processo potrebbe richiedere qualche istante...');
dimab=size(abitazione);                                                     % I nodi del grafo sono le abitazioni, le cui coordinate e indirizzi 
n=dimab(1,1);                                                               % sono contenute in abitazione.txt e indirizzo.txt.
coordinata_x=cell(1,n);                                                     % Ciascuna nodo è associato a un indice, da 1 a n, con n numero di abitazioni.
coordinata_y=cell(1,n);                                                     % Gli indici sono contenuti in names.
names=cell(1,n);                                                           
address=cell(1,n);

for i=1:n
    coordinata_x{i}=abitazione(i,1);
    coordinata_y{i}=abitazione(i,2);
    names{i}=i;
    address{i}=indirizzo{i};
end
                                                                            % Costruisco il grafo non diretto; la funzione prende in ingresso i vettori
G=weighted_undirected_graph(names, coordinata_x, coordinata_y, address);    % names (indici dei nodi), coordinata_x e coordinata_y (coordinate abitazioni)
                                                                            % e address (indirizzi). Queste informazioni vengono memorizzate nel grafo 

for i=1:n                                                                   % Aggiungo gli archi del grafo: il grafo inziiale presenta tutti i possibili
    for j=(i+1):n                                                           % collegamenti tra gli n nodi. 
           
            peso=sqrt((abitazione(i,1)-abitazione(j,1)).^2+(abitazione(i,2)-abitazione(j,2)).^2);
            G.add_edge(i,j,peso);                                           % Il peso degli archi è dato dalla distanza euclidea tra i due nodi: get_node_x   
    end                                                                     % e get_node_y restituiscono le coordinate dei nodi.
end

end
