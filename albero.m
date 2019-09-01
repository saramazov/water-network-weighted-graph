function [D S] = albero(D,S,ind,pesi)                                       % albero: costruisce un albero partendo da un grafo diretto D,
                                                                            % e da una struttura S con i seguenti campi: nodo1, nodo2, peso.
                                                                            % Pesi invece contiene le capacità degli archi lette dal file vincoli.txt
                                                                            % Ind: indice del nodo da cui parte l'albero: alla prima iterazione, è l'acquedotto
for i=1:length(S)
    
    if S(i).nodo1 == ind                                                    % Se trovo l'acquedotto come nodo1, per un certo i, allora:
        tmp = S(i).nodo2;                                                   % memorizzo in tmp il nodo2
        S(i).peso = pesi(tmp);                                              % come peso inserisco la componente di indice tmp del vettore pesi   
        D.add_edge(ind,S(i).nodo2,S(i).peso);                               % aggiungo al grafo l'arco tra i due nodi individuati 
        disp(['arco aggiunto: ' int2str(ind) ' e ' int2str(S(i).nodo2)]);
        S(i).nodo1 = 0; S(i).nodo2 = 0; S(i).peso= 0;                       % cancello i dati della lista S in posizione i
        [D S] = albero(D,S,tmp,pesi);                                       % eseguo di nuovo la funzione albero, partendo dal nodo di indice tmp
        
    elseif S(i).nodo2 == ind                                                % Se trovo l'acquedotto come nodo2, per un certo i, allora:
        tmp = S(i).nodo1;                                                   % memorizzo in tmp il nodo1
        S(i).peso = pesi(tmp);                                              % come peso inserisco la componente di indice tmp del vettore pesi
        D.add_edge(ind,S(i).nodo1,S(i).peso);                               % aggiungo al grafo l'arco tra i due nodi individuati 
        disp(['arco aggiunto: ' int2str(ind) ' e ' int2str(S(i).nodo1)]);
        S(i).nodo1 = 0; S(i).nodo2 = 0; S(i).peso= 0;                       % cancello i dati della lista S in posizione i
        [D S] = albero(D,S,tmp,pesi);                                       % eseguo di nuovo la funzione albero, partendo dal nodo di indice tmp
    end
    
end



