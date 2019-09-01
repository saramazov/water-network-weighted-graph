function flux = more_flux(D,cammino,residuo,flux)                           % more_flux: dato il grafo diretto D, un cammino, e un flusso residuo  
                                                                            % da inviare nella rete, aggiorno il flusso flux.
n=D.get_size();          
fine=length(cammino);                                                       % fine: lunghezza del cammino
 if cammino(1)==(n-1)                                                       % Se il cammino parte dall'acquedotto, allora
     for i=1:(fine-1)                                                       % per tutti gli elementi del cammino, escluso il pozzo:
             appo1=cammino(i);                                              % memorizzo in variabili d'appoggio due nodi successivi del cammino
             appo2=cammino(i+1);                                            % e memorizzo le loro liste di adiacenza
             adj1=D.get_adjlist(appo1);                               
             adj2=D.get_adjlist(appo2);
             for j=1:length(adj1)                                           % visito la lista di adiacenza del primo nodo:
                if adj1(j).nodo==appo2                                      % se il secondo nodo è nella lista di adiacenza, allora ho un arco diretto
                flux(appo1,appo2) = flux(appo1,appo2)+residuo;              % aggiorno il flusso tra i due nodi aggiungendo il flusso residuo
                end
             end
             for j=1:length(adj2)                                           % se invece il primo nodo è nella lista di adiacenza del secondo,  
                if adj2(j).nodo==appo1                                      % allora ho un arco inverso per il grafo diretto D
                flux(appo1,appo2) = flux(appo1,appo2)-residuo;              % aggiorno il flusso sottraendo il flusso residuo
                end
             end
     end
 end 
 
end