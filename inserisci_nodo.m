function [G,abitazione,indirizzo,vincoli]=inserisci_nodo(G,abitazione,indirizzo,vincoli)  % inserisci_nodo: l'utente può aggiungere un nodo al grafo iniziale

n=G.get_size();                                                                    
m=n;

while m==n                                                                   
x=input('Inserisci la coordinata x della nuova abitazione: ');                          % vengono chieste all'utente le coordinate,   
y=input('Inserisci la coordinata y della nuova abitazione: ');                          % l'indirizzo e la capacità    
address=input('inserisci indirizzo della nuova abitazione: ','s');                      % massima in entrata della nuova abitazione.  
capacita=input('inserisci capacita massima in entrata della nuova abitazione: ');                                                   
                                                                            
G.add_node(n+1,x,y,address);                                                            % Aggiungo il nuovo nodo: verifico che non coincida
m=G.get_size();                                                                         % con un'abitazione già esistente. 
end                                                                                     % Altrimenti, richiedo all'utente le informazioni

for i=1:n                                                                               % Aggiungo gli archi tra tutte le abitazioni e il nuovo nodo, 
    peso=sqrt((G.get_node_x(i)-x).^2+(G.get_node_y(i)-y).^2);                           % il cui indice è n+1 (o m)
    G.add_edge(i,n+1,peso);
end
                                                            
    abitazione=[abitazione;x,y];                                                            
    indirizzo=[indirizzo;address];                                                      % Aggiorno abitazione, indirizzo e vincoli con il nuovo nodo
    vincoli=[vincoli;capacita];                                                        
                                                                                       
end
