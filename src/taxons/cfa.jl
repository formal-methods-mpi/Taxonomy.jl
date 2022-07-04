struct GFactor <: AbstractCFA
    nobserved::Judgement
    nerror_covariances::Judgement
    crossloading_incoming::Judgement
    crossloading_outgoing::Judgement
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
