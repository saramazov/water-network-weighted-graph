function listObject = lista_concatenata_struct(nodi, pesi)
  % values e' un array di strutture 
  data = [];
  for i = 1:length(nodi)
    data(i).peso = pesi(i);
    data(i).nodo = nodi(i);
  end
  listObject = struct('display',@display_list,...                      
                      'delete',@delete_element,...
                      'search',@search_element,...
                      'add', @add);

  function res = display_list
    %# Displays the data in the list
    %for i = 1:length(data)
    %    disp(['peso = ' num2str(data(i).peso) '  nodo = ' num2str(data(i).nodo)]);
    %end
    res = data;
  end

  function delete_element(key)
    %# Deletes an element with nodo =  key    
    n = numel(data);    
    for i = 1:n
        if data(i).nodo == key;
            data(i) = [];
            break;
        end
    end    
  end

function res = search_element(key)
    % cerca il nodo key
    n = numel(data);
    res = [];
    for i = 1:n
        if data(i).nodo == key;
            res = [res i];
        end
    end    
end

function a = get_node(key)                 
    % restituisce il nodo key
    n = numel(data); %dimensione di data
    a = [];
    for i = 1:n
        if data(i).nodo == key;
	    tmp=data(i);
            a = [a tmp];
        end
    end    
end


function add(node)
    %# Adds a new node at the beginning
    %   of list elements. Node is assumed being a struct
    data = [node data];
  end
end
