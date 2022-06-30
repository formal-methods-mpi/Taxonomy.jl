"""
Validate DOI via Regex

Regular expression taken from:

https://www.crossref.org/blog/dois-and-matching-regular-expressions/

"""
function valid_doi(x)
    occursin(r"^10.\d{4,9}/[-._;()/:A-Z0-9]+", uppercase(x))
end

"""
Construct a validated DOI

Most valid DOIs (not all) can be simply validated via a regular expression.

# Arguments

- `observed::String`: a DOI without resolver (e.g. without doi.org), capitalization does not matter
- `fallback::String`: an optional fallback link where one maybe can find the content in case the doi fails

```jldoctest
julia> DOI("10.5281/zenodo.6719627")
UsualDOI{String, Missing}("10.5281/ZENODO.6719627", missing)

julia> DOI("10.5281/zenodo.6719627", "https://github.com/StructuralEquationModels/StructuralEquationModels.jl")
UsualDOI{String, String}("10.5281/ZENODO.6719627", "https://github.com/StructuralEquationModels/StructuralEquationModels.jl")
```

"""
struct UsualDOI{T <: String, T2 <: Union{Missing, String}} <: AbstractDOI
    doi::T
    fallback::T2
    function UsualDOI(x::T,y::T2) where {T, T2}
        valid_doi(x) ? new{T, T2}(uppercase(x),y) : error("unusual doi")
    end
end
UsualDOI(x) = UsualDOI(x, missing)

"""
Construct an unvalidated DOI

You should prefer an validated [`UsualDOI`](@ref) but if you have tested the DOI and are sure it links were it supposed to link, go ahead and create an unvalidated doi.

```jldoctest
julia> UnusualDOI("weird10.5281doi/zenodo.6719627")
UnusualDOI{String, Missing}("WEIRD10.5281DOI/ZENODO.6719627", missing)

julia> UnusualDOI("weird10.5281doi/zenodo.6719627", "https://github.com/StructuralEquationModels/StructuralEquationModels.jl")
UnusualDOI{String, String}("WEIRD10.5281DOI/ZENODO.6719627", "https://github.com/StructuralEquationModels/StructuralEquationModels.jl")
```

"""
struct UnusualDOI{T <: String, T2 <: Union{Missing, String}} <: AbstractDOI
    doi::T
    fallback::T2
    UnusualDOI(x::T,y::T2) where {T, T2} = new{T, T2}(uppercase(x),y)
end
UnusualDOI(x) = UnusualDOI(x, missing)

"""
Alias for [`UsualDOI`](@ref).
"""
const DOI = UsualDOI