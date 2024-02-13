## We need to be able to pair judgements with its key:
export Pair
Base.Pair(j::AbstractJudgement) = Pair(judgement_key(j), [j]) 

## 
function add_judgement!(dict, j::T, unique) where {T <: AbstractJudgement} 
    if unique
        p = Pair(j)
        key = first(p)
        haskey(dict, key) ? throw(ArgumentError("The judgement `$key` is supposed to be unique. Remove duplicates or set `@newjudgement(unique = false)`.")) : nothing
        push!(dict, p)
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

    if j isa Taxon
        keyname = Symbol("Taxon")
    else
    keyname = Symbol(string(typeof(j)))
    end
 
    vec = get(dict, keyname, T[])
    push!(vec, j)
    push!(dict, keyname => vec)
end

function judgement_dict(x::Union{AbstractJudgement, JudgementLevel}...) 
    foldl(add_judgement!, x, init = Dict{Symbol, Vector{Union{AbstractJudgement, JudgementLevel}}}())
end

