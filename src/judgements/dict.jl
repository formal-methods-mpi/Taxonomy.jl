## We need to be able to pair judgements with its key:
export Pair
Base.Pair(j::AbstractJudgement) = Pair(judgement_key(j), [j]) 

## 
function add_judgement!(dict, j::T, unique) where {T <: AbstractJudgement} 
    if unique
        push!(dict, Pair(j))
    else
        vec = get(dict, judgement_key(j), T[])
        push!(vec, j)
        push!(dict, judgement_key(j) => vec)
    end
end

function add_judgement!(dict, j::T) where {T <: AbstractJudgement}
    add_judgement!(dict, j, Judgements.judgement_unique(j))
end

function add_judgement!(dict, j::T) where {T <: JudgementLevel}
    keyname = Symbol(string(typeof(j)))
    if (keyname in keys(dict))
        keyname = Symbol(string(keyname) * "_2") ## figure out how to give concisive names
    end

    vec = get(dict, string(typeof(j)), T[])
    push!(vec, j)
    push!(dict, keyname => vec)
end

function judgement_dict(x::Union{AbstractJudgement, JudgementLevel}...) 
    foldl(add_judgement!, x, init = Dict{Symbol, Vector{Union{AbstractJudgement, JudgementLevel}}}())
end

