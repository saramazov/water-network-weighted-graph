% Progetto di: ALICE SCARPA, matricola 795407

clear all;
load abitazione.txt;                      %carico i file:abitazione,indirizzo,vincoli
indirizzo=importdata ('indirizzo.txt');
load vincoli.txt;
a=0;                                     %a è una variabile ausiliaria
dimab=size(abitazione);                 
dimvinc=size(vincoli);
if dimab(1,1)~= dimvinc(1,1)             % verifico che i file abbiano lo stesso numero di righe
    disp('dimensioni dei file non compatibili')
    a=2;                                  %se le righe sono diverse, pongo a=2
elseif dimab(1,2)~=2                      % verifico che abitazione abbia due colonne (2 coordinate)
    disp('numero di coordinate per abitazione non corretto')
    a=2;                                  %se le colonne non sono 2, pongo a=2
end

if a==0   
    G=build_graph(abitazione,indirizzo);  %se a=0, costruisco il grafo iniziale G
    cont=0;                               %cont: conta il numero di esecuzioni della funzione minimum_web (punto 2)
end

while a==0                          %finchè a=0, l'utente visualizza le seguenti opzioni
    val = input('Digita:\n 1 per inserire una nuova abitazione \n 2 per trovare la rete idrica migliore \n 3 per calcolare la quantita massima di flusso inviabile sulla rete \n 4 per visualizzare le abitazioni \n esci per uscire: ','s');
    if strcmp(val,'esci')           %val: variabile a disposizione dell'utente per selezionare le opzioni
        a=1;                        %esco dal programma
    else
        val=str2num(val);
    end
        switch val
            case 1
                
                if cont~=0 
                    G=build_graph(abitazione,indirizzo);                                                  % opzione 1: l'utente può aggiungere
                    [G,abitazione,indirizzo,vincoli] = inserisci_nodo(G,abitazione,indirizzo,vincoli);    % una nuova abitazione. Se è già stato
                    cont=0;                                                                               % eseguito il punto 2, il grafo viene
                elseif cont==0                                                                            % ricostruito nella versione iniziale
                    [G,abitazione,indirizzo,vincoli] = inserisci_nodo(G,abitazione,indirizzo,vincoli);    % e si pone cont=0.
                end
                
            case 2
                
                if cont~=0                                                  % opzione 2: viene realizzata la rete idrica "minima".
                    G=build_graph(abitazione,indirizzo);                    % Se è la prima volta che l'utente esegue questo punto (cont=0),
                    [G,T,cont] = minimum_web(G,cont,abitazione,indirizzo);  % viene chiamata la funzione minimum_web. 
                elseif cont==0                                              % Se l'utente ha già eseguito questo punto (cont>0), 
                    [G,T,cont] = minimum_web(G,cont,abitazione,indirizzo);  % viene prima ricostruito il grafo iniziale. 
                end
                
            case 3
                
                if cont~=0                                                  % opzione 3: il programma calcola il massimo flusso inviabile sulla rete.
                    D = build_directed_graph(vincoli,G,T);                  % Se l'utente ha già eseguito il punto 2 (cont>0),
                    [D,flux] = maximum_flux(D);                             % viene costruito un grafo diretto con build_directed_graph 
                elseif cont==0                                              % e viene trovato il massimo flusso tramite maximum_flux. 
                    [G,T,cont] = minimum_web(G,cont,abitazione,indirizzo);  % Se l'utente non ha ancora eseguito il punto 2 (cont=0), 
                    D = build_directed_graph(vincoli,G,T);                  % viene prima chiamata la funzione minimum_web.
                    [D,flux] = maximum_flux(D);
                end
                
            case 4
                
                visualizza(abitazione,indirizzo);                           % opzione 4: l'utente può visualizzare le informazioni (coordinate e indirizzo)
                                                                            % delle abitazioni esistenti. 
            otherwise                                                      
                if strcmp(num2str(val),'esci')
                    a=1;
                else
                    disp('ritenta, sarai più fortunato!')
                end
        end
end