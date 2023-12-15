"""
    judgement_unique(::AbstractJudgement)

Indicates weather a judgement can be made only once (it is unique) or if it may relate to different entities (it is not unique).
"""
function judgement_unique end

"""
    judgement_key(::AbstractJudgement)

Under which key to find this particular judgement type.
"""
function judgement_key end

"""
    judgement_level(::AbstractJudgement)

For which level this judgement is applicable.
"""
function judgement_level end

function correct_judgement_level(x, level=AnyLevelJudgement)
    x in (level, AnyLevelJudgement)
end

function check_judgement_level(x::AbstractJudgement, level=AnyLevelJudgement)

    x = x isa JudgementLevel ? x : judgement_level(x)
    if !correct_judgement_level(x, level)
        throw(ArgumentError("A `$level` was required but a `$x` was given."))
    end
    nothing
end

function check_judgement_level(x, level=AnyLevelJudgement)
    return (x)
end

macro newjudgement(name, level, doc, type=Any, check=x -> nothing, unique=true)
    inner = quote
        struct $name{T<:Union{<:$(type),Missing}} <: AbstractJudgement{T}
            rating::T
            certainty::Float64
            comment::Union{String,Missing}
            function $name{T}(r, c=1.0, l=missing) where {T}
                $check(r)
                Judgements.check_certainty(c)
                new{T}(r, c, l)
            end
        end
    end
    outer = :($name(r::T, c=1.0, l=missing) where {T} = $name{T}(r, c, l))
    outer2 = :($name(r::AbstractJudgement, c=1.0, l=missing) = throw(ArgumentError("Judgements of Judgements are too meta.")))
    doc = :(@doc """
        $($name)(r::Union{<: $($type), Missing}, c = 1.0, l = missing})

    Level: `$($level)`

    $($doc)

    """ $name)

    unique = :(Judgements.judgement_unique(::$name) = $unique)
    key = :(Judgements.judgement_key(::$name) = Symbol($name))
    level = :(Judgements.judgement_level(::$name) = $level())
   
    # Create a new function with the same name as the judgement
    # This function accepts keyword arguments and creates a NamedTuple
    # The NamedTuple is then passed to the judgement constructor
    keyword_func = quote
        function $name(;kwargs...)
            $(Symbol(esc(name)))(NamedTuple{tuple(keys(kwargs)...)}(values(kwargs)...))
        end
    end
        

    
    return quote
        $(esc(inner))
        $(esc(outer))
        $(esc(outer2))
        $(esc(unique))
        $(esc(level))
        $(esc(key))
        $(esc(doc))
        $(esc(keyword_func))
    end
    end

@newjudgement(
    Judgement,
    AnyLevelJudgement,
    """
    A generic judgment without any checks on content.

    ## Arguments

    - `rating`: The rating, e.g. "Structural" or 1.0.
    - `certainty`: If uncertain, a number between 0.0 and 1.0 (0-100%)
    - `comment`: information on why the judgement was made, may contain information about the source within the paper, e.g., section, page, table number, figure number.

    ```jldoctest
    julia> Judgement(1.0, .99, "Figure 1");
    ```
    """
)

"""
Extract rating from Judgement.

If `rating` is called on a `Judgement` it returns the rating, on everything it returns identity.

"""
rating(x) = x
rating(x::AbstractJudgement) = x.rating

"""
Extract certainty from Judgement.
"""
certainty(x::AbstractJudgement) = x.certainty

"""
Extract comment from Judgement.
"""
comment(x::AbstractJudgement) = x.comment

"""
Shorthand for [`Judgement`](@ref)
"""
const J = Judgement

Base.convert(::Type{T}, x) where {T<:AbstractJudgement} = T(x)
function Base.convert(::Type{T}, x::AbstractJudgement) where {T<:AbstractJudgement}
    x isa T ? x : T(rating(x), certainty(x), comment(x))
end
Base.promote_rule(::Type{T1}, ::Type{T2}) where {T1<:AbstractJudgement{T2}} where {T2} = T1

function ==(x::AbstractJudgement, y::AbstractJudgement)
    isequal(rating(x), rating(y)) &&
        isequal(certainty(x), certainty(y)) &&
        isequal(comment(x), comment(y))
end

"""
Abstaining from any judgement.

This implies that your best guess is missing and you are absolutely uncertain about this judgement.

```jldoctest
julia> NoJudgement()
Judgement{Missing}(missing, 0.0, missing)
```
"""
NoJudgement(comment=missing) = Judgement(missing, 0.0, comment)
