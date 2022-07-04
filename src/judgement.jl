"""
A judgment about any parameter etc.

## Arguments

- `rating`: The rating, e.g. "CFA" or 1.0.
- `certainty`: If uncertain, a number between 0.0 and 1.0 (0-100%)
- `location`: optional, Where in the Paper PDF was the location retieved, e.g. section, page, table number, figure number.

```jldoctest
julia>Judgement(1.0, .99, "Figure 1");
```
"""
struct Judgement{T1, T2 <: Float64, T3 <: Union{String, Missing}}
    rating::T1
    certainty::T2
    location::T3
    function Judgement(r::T1, c::T2, l::T3) where {T1, T2, T3}
        if ((c < 0.0) || (c > 1.0))
            ArgumentError("Certainty must be between 0 and 1.")
        else
            new{T1, T2, T3}(r, c, l)
        end
    end
end
Judgement(r, c) = Judgement(r, c, missing)
Judgement(r) = Judgement(r, 1.0, missing)
Judgemet(;rating, certainty = 1.0, location = missing) = Judgement(rating, certainty, location)
"""
Shorthand for [`Judgement`](@ref)
"""
const J = Judgement
convert(::Type{Judgement}, x) = Judgement(x)
