
"""
Sampling StenoGraphs from CFA Taxon. 

 Arguments

- `taxons`: Vector of CFA Taxons.
- `n`: Integer for the number of StenoGraphs that should be sampled with replacement. Defaults to `1`.

"""
function sample_StenoGraph(taxons::Vector{CFA}, n::Integer = 1)
   
    steno_vec = []
    for i = 1:length(taxons)
       push!(steno_vec, (rating(structural_model(taxons[i]))))
    end

rand_sample = rand(1:length(steno_vec), n)
sample_vec = steno_vec[rand_sample]

return sample_vec

end

## To Do:
## Missings raus
## nach Judegment vorgehen
## Sample all != 0
## Sample all with Judgement Prob > value


