function T = kruskal(G)
% G è un grafo di tipo weighted_undirected_graph. Calcola un MST secondo
% l'algoritmo di Kruskal
n = G.get_size();
pesi=[]; % vettore che conterrà i pesi degli archi. Usato per ordinare gli archi
edgelist = struct('nodo1',0,'nodo2',0); % struttura per memorizzare gli archi.
                                % NOTA: il campo pesi non è in edgelist 
                                % perché per
                                % ordinare i vettori abbiamo già degli
                                % algoritmi. Avremmo dovuto scrivere un
                                % algoritmo per ordinare un vettore di
                                % strutture rispetto ad un campo
cnt = 0; % conta il numero di archi

for i = 1:n   
   adj = G.get_adjlist(i); % adj vettore di strutture contenente i vicini 
                                 % due campi: nodo , peso 
   if ~isempty(adj)
       for j = 1:length(adj)
          if i < adj(j).nodo  % grafo non diretto, considero ogni arco una sola volta             
              cnt = cnt +1;
              edgelist(cnt).nodo1 = i;
              edgelist(cnt).nodo2 = adj(j).nodo;
              pesi(cnt) = adj(j).peso;              
          end    
       end    
   end    
end


[s_edge s_idx] = quicksort(pesi, 1, cnt, 1:cnt); % ordina gli archi per peso crescente, 
                                % s_idx: permutazione ralativa
                                % all'ordinamento
edgelist = edgelist(s_idx); % ordino anche la struttura contenente gli archi.
                            % mantengo cioè la corrispondenza con gli estremi dell'arco


componenti = cell(1,n); % serve per mantenere gli insiemi disgiunti
for i = 1:n % inizialmente ogni nodo è una componente separata
    componenti{i} = i; 
end
T=[];

for i = 1:cnt
    
    arco = edgelist(i);
    nodo1 = arco.nodo1;
    nodo2 = arco.nodo2;
    com1=0;com2=0;
    for j = 1:length(componenti) % cerca i due nodi in tutte le componenti 
                                 % esistenti
        tmp1 = find(nodo1==componenti{j});
        if ~isempty(tmp1)
            com1 = j;
        end
        tmp2 = find(nodo2==componenti{j});
        if ~isempty(tmp2)
            com2 = j;
        end
        if com1>0 && com2>0 % se i due nodi sono stati trovati entrambi, esce
           break;
        end
        
    end    
    if com1 ~= com2 % i nodi appartartenevano a due componenti distinte
        T = [T i];
        disp(['arco  ' num2str(edgelist(i).nodo1) '-' num2str(edgelist(i).nodo2) '  peso  ' num2str(s_edge(i))]);        
        % devo aggiornare gli insiemi disgiunti: aggiungo la seconda
        % componente alla prima, e poi la cancello
        componenti{com1} = [componenti{com1} componenti{com2}];
        componenti{com2} = [];           
    end
    
end


T = edgelist(T);

end
