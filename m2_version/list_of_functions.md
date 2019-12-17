# Functions in `gc.m2`
* `asList (x)` : turns x into a list 

* `sumList {Axis: None, Row, Col} (x)` : sums the entries in list x 

* `combinations {Replacement, MinSum, MaxSum, Order} (list, num)` : takes combinations of list of length num. 

* `sortedIndices (x)`: returns the order of indices for values in in `sort(x)`

* `isPermutation (x, y)`: answers question: is x a permutation of the rows/cols of y? 

* `unorietnedUniqueUpToPermutation (x)`: returns the list of entries of x that are unique up to permutation, where x is a list of unoriented graphs. 

* `allPossibleBaseGraphsForPair (x)`: the admissable base graphs G with G#0 = x#0 and G#1 = x#1

* `undirectedGraphs (d)`: creates all of the (possibly non-connected) undirected graphs in dimension d. 

* `graphEdges {Oriented: true/false, RavelLoops: true/false} (g)`: returns the edges of graph g as a list of lists. 

* `replaceInList (i, v, l)`: replaces the entry in list at index i with value v

* `graphFromEdges {Oriented: true/false} (E)`: takes list of edges and returns the matrix rep of the graph g

* `isGraphConnected (g)`: answers question: is graph g connected? 

* `edgesOutOfPoint {Oriented} (p, E)`: returns the edges in E that are connected to point p

* `isPathBetween {Oriented, SavePath, EdgesAdded} (p, q, E)`: checks if there exists a path between p and q using edges from E, and optionally returns the path. 

* `isEdgeInCycle (i, E)`: answers question: is there a cycle in E containing edge at index i? 

* `splitLoops (m)`: splits the loops in graph g with matrix rep m. 

* `splitEdges (m, E)`: splits the edges in graph m that are at the indices in list E 

* `Step1 (n)`: returns admissable(connected, unique up to undirected graph isomorphism, and with all edges in a cycle) graphs for quiver generation in dimension n. graphs CAN contain loops. 

* `Step2 (m)`: returns the list of all possible graphs generated from a given output of step1 by splitting subsets of the edges and removing all loops. 

* `Step4 (m)`: add the set of all allowable orientations on an unoriented graph m (note that verticesi of valence 2 must be sinks)

* `Step5 (l)`: returns the values of l (where l is a list of directed graphs) that are unique up to isomorphism. 