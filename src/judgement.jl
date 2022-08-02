"""
A judgment about any parameter etc.

## Arguments

- `rating`: The rating, e.g. "CFA" or 1.0.
- `certainty`: If uncertain, a number between 0.0 and 1.0 (0-100%)
- `location`: optional, Where in the Paper PDF was the location retieved, e.g. section, page, table number, figure number.

```jldoctest
julia> Judgement(1.0, .99, "Figure 1");
```
"""
struct Judgement{T}
    rating::T
    certainty::Float64
    location::Union{String, Missing}
    function Judgement(r::T, c, l) where T
        if ((c < 0.0) || (c > 1.0))
            ArgumentError("Certainty must be between 0 and 1.")
        else
            new{T}(r, c, l)
        end
    end
end
Judgement(r, c) = Judgement(r, c, missing)
Judgement(r) = Judgement(r, 1.0, missing)
Judgement(;rating, certainty = 1.0, location = missing) = Judgement(rating, certainty, location)
"""
Shorthand for [`Judgement`](@ref)
"""
const J = Judgement
convert(::Type{Judgement}, x) = Judgement(x)
convert(::Type{Judgement}, x::Judgement) = x
convert(::Type{Judgement{T}}, x) where T = Judgement(convert(T, x))


"""
Abstaining from any judgement.

This implies that your best guess is missing and you are absolutely uncertain about this judgement.

```jldoctest
julia> NoJudgement()
Judgement{Missing}(missing, 0.0, missing)
```
"""
NoJudgement(location = missing) = Judgement(rating = missing, certainty = 0.0, location = location)
