function R=build_R(D,flux)                                                  % build_R: construisco il grafo residuo

R=weighted_directed_graph([],[],[],[]);                                     % R è un grafo diretto
n=D.get_size();

for i=1:n                                                                   % Aggiungo ad R i nodi del grafo D
    appo1=D.get_node_x(i);
    appo2=D.get_node_y(i);
    appo3=D.get_node_address(i);
    R.add_node(i,appo1,appo2,appo3);
end

for i=1:n                                                                   % Visito le liste di adiacenza dei nodi del grafo D
    adj=D.get_adjlist(i);
    
    if ~isempty(adj)                                                        % se la lista non è vuota, allora:
          for j = 1:length(adj)                                             % la percorro tutta
                tmp=adj(j).nodo;                                            % memorizzo in variabili d'appoggio i nodi e i pesi degli archi  
                appo=adj(j).peso;
                if appo>flux(i,tmp)                                         % se l'arco non è saturo, lo aggiungo al grafo residuo R;
                    R.add_edge(i,tmp,appo-flux(i,tmp));                     % il peso del nuovo arco è la differenza tra la capacità dell'arco
                end                                                         % e il flusso tra i 2 nodi considerati
                if flux(i,tmp)~=0                                           % Inoltre, se il flusso sull'arco non è nullo (arco non vuoto)
                R.add_edge(tmp,i,flux(i,tmp));                              % aggiungo un arco inverso, con peso uguale al flusso tra i due nodi
                end
          end
    end
    
    
    
end

end
