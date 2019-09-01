function G = build_graph_no_edge(abitazione,indirizzo)                      % costruisce un grafo con senza archi

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
end