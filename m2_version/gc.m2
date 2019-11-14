------------------------------------------------------------
aslist = x -> (
    if class(x) === List then(
        x
    )
    else if class(x) === Sequence then(
        toList(x)
    )
    else if class(x) === Set then(
        toList(x)
    )
    else
        {x}
)
------------------------------------------------------------

------------------------------------------------------------
-- add all elements of a list together -- 
sumlist = {Axis => "None"} >> opts -> x -> (
    if opts.Axis == "None" then (
        s = 0; 
        for i in x do s = s + i;)
    else if opts.Axis == "row" then (
        s = flatten(for i in x list(sumlist(i)));
    )
    else if opts.Axis == "col" then (
       pivoted = entries(transpose(matrix(x)));
       s = flatten(for i in pivoted list(sumlist(i)));
    );
    s
)
------------------------------------------------------------


------------------------------------------------------------
-- take all possible combinations of length k from list l -- 
-- optional arguments: 
-- -- R("True"/"False") = with replacement
-- -- Minsum(numeric value) = exclude all combinations with sum below Minsum
-- -- Maxsum(numeric value) = exclude all combinations with sum above Maxsum
combinations = {R => "False", Minsum => -1000, Maxsum => -1000} >> opts -> (l, k) -> (
    if k > 1 then (
        -- if we are using combinations with replacement -- 
        if opts.R == "True" then (
           mylist = flatten(join(for i in l list(for j from 0 to k - 1 list(i))));
           combs1 = unique(subsets(mylist, k));
           combs2 = unique(subsets(mylist, k));
           for i in combs2 do (combs1 = append(combs1, reverse(i)));
           combs = unique(combs1);
        )
        else (
           mylist = flatten(for i in l list(i));
           combs1 = unique(subsets(mylist, k));
           combs2 = unique(subsets(mylist, k));
           for i in combs2 do (combs1 = append(combs1, reverse(i)));
           combs = unique(combs1);
        );

        -- if we are using restricting either by a minimum or maximum sum -- 
        if opts.Minsum != -1000 then (
           combs = for i in combs list(if sumlist(i) < opts.Minsum then (continue;) else (i))
        );
        if opts.Maxsum != -1000 then (
           combs = for i in combs list(if sumlist(i) > opts.Maxsum then (continue;) else (i))
        );
    )
    else
        combs = for i in l list(i);

    combs
)
------------------------------------------------------------


------------------------------------------------------------
isPerm = (x, y) -> (
    toRet = "False";
    ax = entries(transpose(x));
    ay = entries(transpose(y));
    vals = toList (0..#ax - 1);
    allPermutations = permutations(vals);
    for perm in allPermutations do (
        if ax_perm == ay then (
            toRet = "True";
            break;
        );
    );
    toRet
)
------------------------------------------------------------


------------------------------------------------------------
-- get unique entries from list of undirected graphs -- 
unorientedUniqueUpToPermutation = x -> (
    if #x > 1 then (
        toSave = (0..(#x - 1));
        for i from 0 to #x - 2 do (
            for j from i + 1 to #x - 1 do (
                if isPerm(x#i, x#j) == "False" then (
                    continue;
                )
                else (
                    toSave = delete(j, toSave);
                )
            )
        );
        for i in toSave list(x#i)
    )
    else x
)
------------------------------------------------------------


------------------------------------------------------------
-- create all possible base graphs for quiver generation -- 
allPossibleBaseGraphsForPair = (x) -> (
   g0 = x#0;
   g1 = x#1;

   -- get all possible columns for connectivity matrix (entries must be 0,1, or 2)
   possibleCols = combinations({0,1,2}, g0, R=>"True", Minsum => 2, Maxsum => 2);

   -- all combinations of columns to create rows
   rowCombs = combinations((0..(#possibleCols - 1)), g1, R=>"True");
   candidateMats = for i in rowCombs list(for j in i list(aslist(possibleCols#j)));
   candidateMats = for i in candidateMats list(transpose(matrix(i)));
   candidateMats = for i in candidateMats list(if min(sumlist(entries(i), Axis=>"row")) >= 3 then (i) else continue);
   unorientedUniqueUpToPermutation(candidateMats)
)
------------------------------------------------------------


------------------------------------------------------------
undirectedGraphs = (d) -> (
   gPairs = apply((1..2*(d - 1)), i -> {i, i+d-1});
   connectivityMatrices = allPossibleBaseGraphsForPair \ gPairs;
   connectivityMatrices
)
------------------------------------------------------------


------------------------------------------------------------
pathBetween = (p, q, E) -> (
)
------------------------------------------------------------
