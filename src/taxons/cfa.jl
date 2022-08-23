struct GFactor <: AbstractCFA
    nobserved::Judgement{ <: Int}
    nerror_covariances::Judgement{ <: Int}
    crossloading_incoming::Judgement{ <: Int}
    crossloading_outgoing::Judgement{ <: Int}
    GFactor(nobserved, nerror_covariances, crossloading_incoming, crossloading_outgoing) =
        new(J(nobserved), J(nerror_covariances), J(crossloading_incoming), J(crossloading_outgoing))
end

function GFactor(;nobserved,
    nerror_covariances,
    crossloading_incoming = 0,
    crossloading_outgoing = 0)
    GFactor(nobserved, nerror_covariances, crossloading_incoming, crossloading_outgoing)
end

struct HierachicalCFA <: AbstractCFA
    higher::AbstractCFA
    lower::Vector{AbstractCFA}
end

struct Pathmodel
    nobserved::Judgement
    ndirected::Judgement
    nundirected::Judgement
end



"""
CFA Taxon. 

## Arguments

- `nfactors`: Number of latent variables.
- `nobserved`: Vector of manifest variables for each vector. 
- `nerror_covariances_within`: Vector of covariances within factor.
- `nerror_covariances_between`: Vector of covariances between factors. 

```jldoc
julia> CFA(nfactors = 3, 
           nobserved = [3,4,3],
           nerror_covariances_within = [1, 2, 0])
```
"""

struct CFA <: AbstractCFA
    nfactors::Judgement{ <: Union{ <:Int, Missing}}
     # measurement model
     nobserved::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     nerror_covariances_within::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     nerror_covariances_between::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     crossloading_items::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     # structural model
     latent_correlation::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     latent_incoming::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     latent_outgoing::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     level::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     CFA(nfactors, nobserved, nerror_covariances_within, nerror_covariances_between, crossloading_items, latent_covariances, latent_incoming, latent_outgoing, level) = 
        new(J(nfactors), J(nobserved), J(nerror_covariances_within), J(nerror_covariances_between), J(crossloading_items), J(latent_covariances), J(latent_incoming), J(latent_outgoing), J(level))
end

 function CFA(; nfactors, 
    nobserved,
     nerror_covariances_within = fill(0, nfactors),
     nerror_covariances_between = fill(0, nfactors),
     crossloading_items = fill(0, nfactors), 
     latent_covariances = fill(0, nfactors),
     latent_incoming = fill(0, nfactors),
     latent_outgoing = fill(0, nfactors),
     level = fill(0, nfactors)
     )

     compare_length(value::Judgement) = length(rating(value)) != nfactors
     compare_length(value::AbstractArray{ <: Number}) = length(rating(value)) != nfactors

    for i in [nobserved, nerror_covariances_within, nerror_covariances_between, crossloading_items, latent_covariances, latent_incoming, latent_outgoing, level]
        
        print(i)
        if compare_length(i)
            @warn string(i, " does not include the amount of elements nfactors makes believe")
        end
    end

     CFA(nfactors, nobserved, nerror_covariances_within, nerror_covariances_between, crossloading_items, latent_covariances, latent_incoming, latent_outgoing, level)
end

