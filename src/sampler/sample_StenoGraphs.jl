
# Funktion soll erstmal nur eine Liste von Stenographs als Input bekommen. 
# Erweiterte Funktionalität wäre etwas, was aus gegebenen Taxons eine Liste von Stenographs extrahieren kann.  
## Input: Array/List/Vector von StenoGraphs
## Output: Ein zufälliges Element aus dieser List. 
## Evtl. Später: Mittelwerte etc. 
"""
Sampling StenoGraphs from a vector of StenoGraphs. 

 Arguments

- `steno_vec`: Vector of [StenoGraph].
- `n`: Integer for the number of [StenoGraph]'s that should be sampled with replacement. Defaults to `1`.

"""
function sample_StenoGraph(steno_vec::Union{Vector{Vector}, AbstractArray{<: StenoGraphs.AbstractEdge}}, n::Integer)
    if (all(ismissing, steno_vec))
        return missing
    end

    steno_vec = [x for x in steno_vec if !ismissing(x)]
    rand_sample = rand(1:length(steno_vec), n)
    sample_vec = steno_vec[rand_sample]
    return sample_vec
end

## To Do:
## nach Judegment vorgehen
## Sample all != 0
## Sample all with Judgement Prob > value


#    steno_vec = []
#    for i = 1:length(taxons)
#       push!(steno_vec, (rating(structural_model(taxons[i]))))
#    end
