# water-network-weighted-graph
Simulation of a water network using weighted graphs in Matlab

The main program is in progetto.m, where three txt files need to be uploaded: abitazione.txt (list of houses), indirizzo.txt (locations of houses) and vincoli.txt (constraints on houses water supply capacity).
The program creates a weighted undirected graph, where the houses are the nodes and the arcs are all the possible connections between houses. The arcs weights represent the euclidean distance between houses locations. The graph is built by the function build_graph.
The user can choose between 4 options: 

a) Insert new house/node

b) Find the best water network to supply all houses. The criterium I used to determine the best network is as follows: minimise the total weight of the arcs/pipes where the water runs, i.e. minimise total pipe distance. Water is supplied by a source (another node of the graph). To find the minimum network I implemented the algorithm kruskal. In brief: every arc is considered a disjoint set, and a list T of arcs is initialised. Quicksort is used to order the arcs by their weight: then, the arc wih the minimum weight is added to the list T, and the two nodes connected are put in the same set. The algorithm then looks for the second shortest arc, and adds it to the list if the two nodes are not already connected. Kruskal terminates when all arcs have been examined, i.e put in the same set. 

c) If option b) has been chosen, then the user can find the maximum flux of water supplied by the network. To do this, I exploited the Ford-Fulkerson algorithm. First, a residual graph is built, which has the same nodes as the original graph, but two arcs for each one of the originals: one with weight w(i,j)-flux(i,j), where flux(i,j) is the water flux between the two nodes, and another one with weight flux(i,j). Full or empty arcs are not included in the residual graph.
Next, the algorithm looks for an "increasing path", i..e a patch from the source to the leaves of the graph where it's possible to supply more water (i.e. the arcs are not fully loaded). This is done through a DFS visit of the residual graph. Finally, the flux is updated. 
The algorithm terminates when the DFS visit does not reache the leaves of the graph, i.e. an increasing path cannot be found.

d) Visualise the graph nodes. 


ESECUTION TIME


