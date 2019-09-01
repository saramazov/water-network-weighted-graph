function visualizza(abitazione,indirizzo)                                   % visualizza: mostro le abitazioni con relative informazioni
disp('Mostro le abitazioni esistenti, con coordinate e indirizzo: ');
dim=size(abitazione);

for i=1:dim(1,1)
    info{i,1}=abitazione(i,1); 
    info{i,2}=abitazione(i,2);
    info{i,3}=indirizzo{i};
end
info                                                                        % info contiene le informazioni di ogni abitazione
end