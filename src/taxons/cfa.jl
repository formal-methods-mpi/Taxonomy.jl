struct GFactor <: AbstractCFA
    nobserved::Judgement{Int}
    nerror_covariances::Judgement{Int}
    crossloading_incoming::Judgement{Int}
    crossloading_outgoing::Judgement{Int}
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
