macro newjudgement(name, level, doc, type = Any, check = x -> nothing)
    inner = quote
            struct $name{T <: Union{<: $(type), Missing}} <: AbstractJudgement{T}
            rating::T
            certainty::Float64
            location::Union{String, Missing}
            function $name{T}(r, c, l) where T
                $check(r)
                check_certainty(c)
                new{T}(r, c, l)
            end
        end
    end
    outer = :($name(r::T, c = 1.0, l = missing) where T = $name{T}(r, c, l))
    doc = :(@doc """
        $($name)(r::Union{<: $($type), Missing}, c = 1.0, l = missing})

    Level: `$($level)`

    $($doc)

    """ $name)
    return quote
        $(esc(inner))
        $(esc(outer))
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

convert(::Type{Judgement}, x) = Judgement(x)
convert(::Type{T}, x::T) where {T <: Judgement} = x
convert(::Type{Judgement{T}}, x) where T = Judgement{T}(convert(T, x))

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
NoJudgement(location = missing) = Judgement(rating = missing, certainty = 0.0, location = location)
