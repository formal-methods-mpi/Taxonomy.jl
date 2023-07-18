"""
Sample random [StenoGraph]'s from [LatentPathmodel]'s. 

## Arguments

- `taxon_vec`: Vector of LatentPathmodels.
- `n`: Number of StenoGraphs that should be sampled. 

```jldoctest
using StenoGraphs
using Random

graph_1 = StenoGraphs.@StenoGraph begin
    # latent regressions
    fac1 → fac2
end

struct NodeLabel_2 <: NodeModifier
    l
end
graph_2 = StenoGraphs.@StenoGraph begin
    # latent regressions
    fac1 → fac2^NodeLabel_2("Home an der Spree")
end

latent_path_example_1 = LatentPathmodel(
    Structural(n_sample = 12, structural_graph = graph_1),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)

latent_path_example_2 = LatentPathmodel(
    Structural(n_sample = 12, structural_graph = graph_2),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)

Random.seed!(666)
sample_StenoGraph([latent_path_example_1, latent_path_example_2])


# output
1-element Vector{Vector}:
 fac1 → fac2^NodeLabel_2("Home an der Spree")
```
"""
function sample_StenoGraph(taxon_vec::Union{LatentPathmodel, Vector{LatentPathmodel}}, n::Integer=1)
    steno_vec = extract_StenoGraph(taxon_vec)
    sample_vec = sample_steno(steno_vec, n)

    return(sample_vec)
end

###########
## Utils ##
###########

"""
Extract StenoGraphs from a list of Taxons (currently of Type [LatentPathmodel]), and return their StenoGraphs. 

 Arguments

- `taxon_vec`: Vector of [LatentPathmodel]'s.

"""
function extract_StenoGraph(taxon_vec::Union{LatentPathmodel, Vector{LatentPathmodel}})
    steno_vec = rating.(structural_graph.(structural_model.(taxon_vec)))
    return(steno_vec)
end


"""
Sampling random StenoGraphs from a vector of StenoGraphs. 

 Arguments

- `steno_vec`: Vector of [StenoGraph].
- `n`: Integer for the number of [StenoGraph]'s that should be sampled with replacement. Defaults to `1`.

"""
function sample_steno(steno_vec::Union{Vector{<:Union{Vector, StenoGraphs.AbstractEdge, Missing}}, AbstractArray{<: StenoGraphs.AbstractEdge}}, n::Integer=1)
    if (all(ismissing, steno_vec))
        return missing
    end

    steno_vec = [x for x in steno_vec if !ismissing(x)]
    rand_sample = rand(1:length(steno_vec), n)
    sample_vec = steno_vec[rand_sample]
    sample_vec = vec(sample_vec)
    return sample_vec
end