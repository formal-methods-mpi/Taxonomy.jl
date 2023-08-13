macro newjudgement(name, level, doc, type = Any, check = x -> nothing)
    inner = quote
            struct $name{T <: Union{<: $(type), Missing}} <: AbstractJudgement{T}
            rating::T
            certainty::Float64
            location::Union{String, Missing}
            function $name{T}(r, c = 1.0, l = missing) where T
                $check(r)
                check_certainty(c)
                new{T}(r, c, l)
            end
        end
    end
    outer = :($name(r::T, c = 1.0, l = missing) where T = $name{T}(r, c, l))
    outer2 = :($name(r::AbstractJudgement, c = 1.0, l = missing) = throw(ArgumentError("Judgements of Judgements are too meta.")))
    doc = :(@doc """
        $($name)(r::Union{<: $($type), Missing}, c = 1.0, l = missing})

    Level: `$($level)`

    $($doc)

    """ $name)
    return quote
        $(esc(inner))
        $(esc(outer))
        $(esc(outer2))
        $(esc(doc))
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
    - `location`: optional, where in the Paper PDF was the location retieved, e.g. section, page, table number, figure number.
    
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
Extract location from Judgement.
"""
location(x::AbstractJudgement) = x.location

"""
Shorthand for [`Judgement`](@ref)
"""
const J = Judgement

Base.convert(::Type{T}, x) where {T <: AbstractJudgement} = T(x)
function Base.convert(::Type{T}, x::AbstractJudgement) where {T <: AbstractJudgement} 
    x isa T ? x : T(rating(x), certainty(x), location(x))
end
Base.promote_rule(::Type{T1}, ::Type{T2}) where {T1 <: AbstractJudgement{T2}} where T2 = T1

function ==(x::AbstractJudgement, y::AbstractJudgement)
    isequal(rating(x), rating(y)) &&
    isequal(certainty(x), certainty(y)) &&
    isequal(location(x), location(y))
end

"""
Abstaining from any judgement.

This implies that your best guess is missing and you are absolutely uncertain about this judgement.

```jldoctest
julia> NoJudgement()
Judgement{Missing}(missing, 0.0, missing)
```
"""
NoJudgement(location = missing) = Judgement(missing, 0.0, location)
