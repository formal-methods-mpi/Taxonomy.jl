












###########
## Utils ##
###########

"""
Extract StenoGraphs from a list of Taxons (currently of Type [LatentPathmodel]), and return their stenoGraphs. 

 Arguments

- `taxon_vec`: Vector of [LatentPathmodel]'s.

"""
function extract_StenoGraph(taxon_vec::Union{LatentPathmodel, Vector{LatentPathmodel}})
    steno_vec = []
    for i = eachindex(1:length(taxon_vec))
       push!(steno_vec, (rating(structural_graph(structural_model(taxon_vec[i])))))
    end
    return(steno_vec)
end


"""
Sampling random StenoGraphs from a vector of StenoGraphs. 

 Arguments

- `steno_vec`: Vector of [StenoGraph].
- `n`: Integer for the number of [StenoGraph]'s that should be sampled with replacement. Defaults to `1`.

"""
function sample_steno(steno_vec::Union{Vector{<:Union{Vector, Missing}}, AbstractArray{<: StenoGraphs.AbstractEdge}}, n::Integer)
    if (all(ismissing, steno_vec))
        return missing
    end

    steno_vec = [x for x in steno_vec if !ismissing(x)]
    rand_sample = rand(1:length(steno_vec), n)
    sample_vec = steno_vec[rand_sample]
    sample_vec = vec(sample_vec)
    return sample_vec
end