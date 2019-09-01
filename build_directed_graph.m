function D = build_directed_graph(vincoli,G,T)                              % build_directed_graph: costruisco un grafo diretto partendo dal grafo 
p=size(vincoli);                                                            % non diretto restituito dalla funzione minimum_web.
r=p(1,1);
for i=1:r
    pesi(i)=vincoli(i,1);                                                   % Memorizzo in pesi le capacità massime in entrata di ogni abitazione (vincoli.txt)
end
D=weighted_directed_graph([],[],[],[]);                                     % D è il nuovo grafo: grafo diretto pesato
n=G.get_size();

for i=1:n                                                                   % Aggiungo a D gli stessi nodi presenti nel grafo G, ovvero tutte le 
    appo1=G.get_node_x(i);                                                  % abitazioni e l'acquedotto.
    appo2=G.get_node_y(i);                                                 
    appo3=G.get_node_address(i);
    D.add_node(i,appo1,appo2,appo3);
end
D.add_node(n+1,Inf,Inf,'pozzo');                                            % Aggiungo un pozzo fittizio: servirà per la funzione maximum_flux.
S=struct('nodo1',0,'nodo2',0,'peso',0);                                     % Il pozzo si trova in posizione (inf,inf) in modo che non si sovrapponga
                                                                            % a nessuna abitazione. Viene memorizzato come ultimo nodo del grafo (dopo l'acquedotto)
for i=1:length(T)                                                           % Memorizzo nella struct S gli archi contenuti nel grafo G: sfrutto la   
    S(i).nodo1=T(i).nodo1;                                                  % lista T restituita dalla funzione minimum_web. Inizialmente assegno pesi nulli.     
    S(i).nodo2=T(i).nodo2;
    S(i).peso=0;
end 

[D S]=albero(D,S,n,pesi);                                                   % La funzione albero rende il grafo D un albero, utilizzando gli archi  
                                                                            % memorizzati in S e le capacita dei condotti memorizzate in pesi.   
                                                                            % L'albero viene costruito partendo da un nodo sorgente: in questo caso 
                                                                            % è l'acquedotto, con indice n (dimensione di G, grafo non diretto).
for i=1:(n-1)                                                               % Infine, costruisco gli archi che entrano nel pozzo fittizio: i nodi 
    adj=D.get_adjlist(i);                                                   % collegati al pozzo sono quelli che non hanno altri archi in uscita,
    if isempty(adj)                                                         % ovvero le foglie dell'albero. n-1 è il numero di abitazioni, mentre
        D.add_edge(i,n+1,Inf);%n+1 + l'indice del pozzo fittizio            % n+1 è l'indice del pozzo. L'acquedotto, di indice n, non viene collegato
    end                                                                     % al pozzo. Dal pozzo non esce nessun arco. 
end                                                                         % La capacità degli archi che entrano nel pozzo è infinita.
end
