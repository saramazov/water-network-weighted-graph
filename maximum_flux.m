function [D,flux] = maximum_flux(D)                                         % maximum_flux: dato il grafo diretto D, trovo il massimo flusso 
n=D.get_size();                                                             % inviabile nella rete.   
for i=1:n                                                                   % Inizializzo il flusso per ogni arco (i,j), che va dal nodo i al
    for j=1:n                                                               % nodo j, con 0. flux è una matrice. 
        flux(i,j)=0;
    end
end

residuo=1;                                                                  % Residuo è una variabile in cui memorizzo il flusso residuo invabile nella rete. 

while residuo~=0                                                            % Finchè residuo è diverso da 0, eseguo i seguenti passi:
      R = build_R(D,flux);                                                  % build_R: costruisco il grafo residuo R, dati il grafo D e il flusso flux
      [cammino,residuo] = find_path(R);                                     % find_path: trovo un cammino aumentate nel grafo R e il flusso residuo inviabile sul cammino    
      flux = more_flux(D,cammino,residuo,flux);                             % more_flux: invio flusso residuo sul cammino trovato, ovvero aggiorno il flusso
      disp(['flusso residuo: ' int2str(residuo)]);
end

dim=size(flux);                                                             
k=dim(1,1);
tmp=0;
for i=1:k                                                                   % Calcolo il valore del flusso: per far questo,
    tmp=tmp+flux(i,n);                                                      % calcolo il flusso totale entrante nel pozzo (indice n, dimensione di D)
end                                                                         % e lo confronto con quello uscente dall'acquedotto: devono essere uguali. 

k_2=dim(1,2);
tmp_2=0;

for i=1:k_2
    tmp_2=tmp_2+flux(n-1,i);
end

if (tmp==tmp_2)
    disp('Il massimo flusso inviabile sulla rete e ');
    disp(tmp);
else
    disp('Errore nel programma');
end
