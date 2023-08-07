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
struct Judgement{T}  <: AbstractJudgement{T}
    rating::T
    certainty::Float64
    location::Union{String, Missing}
    function Judgement{T}(r, c, l) where T
        if isa(r, Judgement)
            throw(ArgumentError("A Judgement of a Judgment is too meta for my taste."))
        elseif ((c < 0.0) || (c > 1.0))
            throw(ArgumentError("Certainty must be between 0 and 1."))
        else
            new{T}(r, c, l)
        end
    end
end
Judgement(r::T, c = 1.0, l = missing) where T = Judgement{T}(r, c, l)
Judgement{T}(r::T) where T = Judgement{T}(r, 1.0, missing)
Judgement{T}(r::T, c) where T = Judgement{T}(r, c, missing)
Judgement(;rating, certainty = 1.0, location = missing) = Judgement(rating, certainty, location)
Judgement(x::Judgement) = x

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
