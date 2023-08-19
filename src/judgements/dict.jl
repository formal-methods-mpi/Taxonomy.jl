export Pair
Base.Pair(j::AbstractJudgement) = Pair(judgement_key(j), [j])
export Judgements
function add_judgement!(dict, j::T, unique) where {T <: AbstractJudgement}
    if unique
        push!(dict, Pair(j))
    else
        vec = get(dict, judgement_key(j), T[])
        push!(vec, j)
        push!(dict, judgement_key(j) => vec)
    end
end
add_judgement!(dict, j) = add_judgement!(dict, j, Judgements.judgement_unique(j))
export judgement_dict
judgement_dict(x::AbstractJudgement...) = foldl(add_judgement!, x, init = Dict{Symbol, Vector{AbstractJudgement}}())
