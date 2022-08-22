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


############################# CFA Tries
using Taxonomy

struct CFA <: AbstractCFA
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
     CFA(nobserved, nerror_covariances_within, nerror_covariances_between, crossloading_items, latent_covariances, latent_incoming, latent_outgoing, level) = 
        new(J(nobserved), J(nerror_covariances_within), J(nerror_covariances_between), J(crossloading_items), J(latent_covariances), J(latent_incoming), J(latent_outgoing), J(level))
end

 function CFA(; nobserved,
     nerror_covariances_within = fill(0, length(nobserved)),
     nerror_covariances_between = fill(0, length(nobserved)),
     crossloading_items = fill(0, length(nobserved)), 
     latent_covariances = fill(0, length(nobserved)),
     latent_incoming = fill(0, length(nobserved)),
     latent_outgoing = fill(0, length(nobserved)),
     level = fill(0, length(nobserved))
     )
     #if # checken, ob alle vektoren die gleiche länge wie factor_id haben
     CFA(nobserved, nerror_covariances_within, nerror_covariances_between, crossloading_items, latent_covariances, latent_incoming, latent_outgoing, level)
end


test_cfa = CFA(
    nobserved = [3, 3, 3],
    #nerror_covariances_within = [1,0,0],
    nerror_covariances_between = [1, 2, 1],
    crossloading_items = [1, 0, 0],
    latent_covariances = [1, 1, 0],
    latent_outgoing = [0, 1, 0],
    latent_incoming = [0, 0, 1],
    level = [1,1,1]       
)


# for i in fieldnames(typeof(test_cfa))
#     print(length(getfield(test_cfa, i)))
# end

#i = fieldnames(typeof(test_cfa))[1]
