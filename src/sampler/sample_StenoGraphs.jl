
# Funktion soll erstmal nur eine Liste von Stenographs als Input bekommen. 
# Erweiterte Funktionalität wäre etwas, was aus gegebenen Taxons eine Liste von Stenographs extrahieren kann.  
## Input: Array/List/Vector von StenoGraphs
## Output: Ein zufälliges Element aus dieser List. 
## Evtl. Später: Mittelwerte etc. 

## Extract all Stenographs from a list of taxons and return a random one.

function extract_StenoGraph(taxon_vec::Vector{Taxon})
    steno_vec = []
    for i = 1:length(taxon_vec)
       push!(steno_vec, (rating(structural_model(taxon_vec[i]))))
    end
end

"""
Sampling StenoGraphs from a vector of StenoGraphs. 

 Arguments

- `steno_vec`: Vector of [StenoGraph].
- `n`: Integer for the number of [StenoGraph]'s that should be sampled with replacement. Defaults to `1`.

"""
function sample_StenoGraph(steno_vec::Union{Vector{<:Union{Vector, Missing}}, AbstractArray{<: StenoGraphs.AbstractEdge}}, n::Integer)
    if (all(ismissing, steno_vec))
        return missing
    end

    steno_vec = [x for x in steno_vec if !ismissing(x)]
    rand_sample = rand(1:length(steno_vec), n)
    sample_vec = steno_vec[rand_sample]
    sample_vec = vec(sample_vec)
    return sample_vec
end





## To Do:
## nach Judegment vorgehen
## Sample all != 0
## Sample all with Judgement Prob > value


