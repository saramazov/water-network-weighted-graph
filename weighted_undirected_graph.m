function G = weighted_undirected_graph(names,coord_x,coord_y,ind)           % Costruisco il grafo sfruttando i vettori che contengono
                                                                            % gli indici, le coordinate e gli indirizzi delle abitazioni
    size_ = length(names);  
    adj = cell(1, size_);
    node_names = names;                                                     % Names contiene gli indici dei nodi del grafo
    coordinata_x = coord_x;                                                 % Coordinata_x memorizza la prima coordinata dei nodi
    coordinata_y = coord_y;                                                 % Coordinata_y memorizza la prima coordinata dei nodi
    indirizzo = ind;                                                        % Indirizzo memorizza la prima coordinata dei nodi
    for i = 1:size_
       adj{i} = lista_concatenata_struct([]);
    end
    G = struct('get_adjlist', @get_adj,...
               'get_node_name', @get_node_name,...
               'get_node_x', @get_node_x,...
               'get_node_y', @get_node_y,...
               'get_node_address', @get_node_address,...
               'get_size', @get_size_,...
               'add_node', @add_node_,...
               'remove_edge', @remove_edge_,...
               'get_all_adjlist', @get_all_adj,...
               'peso_arco', @peso_arco,...
               'add_edge',@add_edge);
    
    function add_edge(i, j, peso)
     %if i<=size_ && j<=size_                                                 % verifico, prima d tutto, che i e j siano effettivamente due nodi del grafo
     %if isempty(adj{j}.search(i)) && isempty(adj{i}.search(j))
        tmpi.peso = peso; tmpi.nodo = i;
        adj{j}.add(tmpi);
        tmpj.peso = peso; tmpj.nodo = j;
        adj{i}.add(tmpj);        
     %else
      %  disp('arco gia  presente');
     %end
     %else
      %  disp('nodo non presente')
     %end
    end

    function res = get_all_adj()        
        res = adj;
    end

    function [adj_i] = get_adj(i)
    if i <= size_
        adj_i = adj{i}.display();
    else
        disp('nodo non presente');
        adj_i = [];
    end
    end

    function info = get_node_name(i)
    if i <= size_
        info = node_names{i};
    else
        disp('nodo non presente');
    end
    end
    
    function info = get_node_x(i)                                           % get_node_x(i): ottengo la coordinata x del nodo di indice i
    if i <= size_
        info = coordinata_x{i};
    else
        disp('nodo non presente');
    end
    end   
 
    function info = get_node_y(i)                                           % get_node_y(i): ottengo la coordinata y del nodo di indice i
    if i <= size_
        info = coordinata_y{i};
    else
        disp('nodo non presente');
    end
    end
    
    function info = get_node_address(i)                                     % get_node_address(i): ottengo l'indirizzo del nodo di indice i
    if i <= size_
        info = indirizzo{i};
    else
        disp('nodo non presente');
    end
    end

    function size = get_size_()
     size = size_;        
    end 
           
    function add_node_(name,x,y,address)
        trovato = false;
     for i = 1:size_
         if(name == node_names{i})
             disp('nodo gia presente');
             trovato = true;
         end    
     end
     for i = 1:size_                                                        % Verifico che non vi sia un nodo con le stesse coordinate dei nodi 
         if(x == coordinata_x{i} && y==coordinata_y{i})                     % già presenti nel grafo  
             disp('nodo gia  presente');
             trovato = true;
         end    
     end     
     if ~trovato 
        size_= size_+1;
        b = lista_concatenata_struct([]);
        adj = [adj b];
        c = cell(1, 1);
        c{1} = name;
        node_names = [node_names c]; 
        d = cell(1, 1);
        d{1} = x;
        coordinata_x = [coordinata_x d];
        e = cell(1, 1);
        e{1} = y;
        coordinata_y = [coordinata_y e];
        f = cell(1, 1);
        f{1} = address;
        indirizzo=[indirizzo f];
     end
    end
    
function remove_edge_(i,j)
        if ~isempty(adj{j}.search(i)) && ~isempty(adj{i}.search(j))
            adj{j}.delete(i);
            adj{i}.delete(j);
        else
            disp('arco non presente');
        end         
end 


function peso = peso_arco(i,j)
    if i <= size_ && ~isempty(adj{i}.search(j))
	tmp   = adj{i}.search(j);   % search restituisce l'indice del nodo j adiacente al nodo i (l'indice nella lista di adiacenza)
	pippo = adj{i}.display();   % display invece restituisce tutta la lista di adiacenza del nodo i
	peso  = pippo(tmp).peso;    % pippo(tmp) è l'elemento della lista di adiacenza di i che corrisponde al nodo j; cerco il peso, ovvero il peso di i-j    
    else
        disp('nodo/arco non presente');
    end
end

end
