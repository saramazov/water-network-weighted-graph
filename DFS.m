function [d, f, p, t] = DFS(R)           % Visita DFS del grafo residuo R

n = R.get_size();
% colori : 0 per bianco, 1 per grigio, 2 per nero
color = zeros(1,n);
p = zeros(1,n);            % vettore dei predecessori/padri
d = p;               % vettore dei tempi di inizio visita
f = p;               % vettore dei tempi di fine visita
time = 0;
t=zeros(1,n);  % Vettore che conterrà, per ogni nodo, il minimo tra le capacità degli archi che collegano il nodo alla sorgente (inizializzate a 0). 
t(n-1)=Inf;    % L'acquedotto, ovvero il penultimo nodo del grafo (indice n-1), ha capacità infinita: in questo modo, t(i)<t(n-1) per ogni i. 
[color, d, time, f, p, t] = DFS_VISIT(R, n-1, color, d, time, f, p, t);	 % Visita DFS partendo dall'acquedotto (nodo n-1): gli eventuali nodi ancora bianchi
                                                                         % non vengono visitati 
end
