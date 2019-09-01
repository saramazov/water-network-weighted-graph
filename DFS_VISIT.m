function [color, d, time, f, p, t] = DFS_VISIT(R, i, color, d, time, f, p, t)   % visita DFS a partire dal nodo di indice i

 color(i) = 1;	 % vertice diventa grigio, appena scoperto 
 d(i) = time;		% tempo inizio visita lista adiacenza
 time = time + 1;
 n=R.get_size();    % n: numero dei nodi, compresi acquedotto e pozzo
                    % Operazioni sul nodo:
 adj=R.get_adjlist(i);
 for j = 1:length(adj)   % Visito la lista di adiacenza del nodo i
     appo=adj(j).nodo;   % appo: variabile d'appoggio in cui è memorizzato il nodo corrispondente all'indice j della lista di adiacenza  
     
	if appo==n                    % Se il nodo è il pozzo, allora:
         p(n) = i;                % il suo predecessore è il nodo i
         disp(['predecessore di: ' int2str(n) ' e ' int2str(i)]);
         t(n) = t(i);             % t(n)=t(i), poichè l'arco che collega il nodo i al pozzo ha capacità infinita, quindi maggiore di t(i)
         break	                  % esco dal ciclo: non continuo la visita nei restanti nodi della lista di adiacenza di i
 	elseif color(appo) == 0       % Se invece il nodo appo è ancora bianco, allora:
         p(appo) = i;             % il predecessore di appo è il nodo i 
         disp(['predecessore di: ' int2str(appo) ' e ' int2str(i)]);
		if adj(j).peso < t(i)     % se il peso dell'arco (i,j) è minore di t(i), allora
            t(appo)=adj(j).peso;  % memorizzo in t(appo) il peso dell'arco
        else 
            t(appo)=t(i);         % altrimenti memorizzo t(i), poichè minore del peso
        end 
                                  % visito subito il vertice non  ancora scoperto
         [color, d, time, f, p, t] = DFS_VISIT(R, appo, color, d, time, f, p, t); 
         if p(n)~=0               % se il pozzo è stato raggiunto, esco dal ciclo
             break;
         end
    end    
 end 
 color(i) = 2;          % vertice diventa nero: ho visitato tutta la sua lista di adiacenza, oppure sono arrivato al pozzo                                                        
 f(i) = time; 			% tempo fine visita lista adiacenza
 time = time + 1;
end
 
