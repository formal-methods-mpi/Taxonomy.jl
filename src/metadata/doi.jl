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

- `doi::String`: a DOI without resolver (e.g. without doi.org), capitalization does not matter
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

"""
What to do if there is no doi

Last resort if there is no DOI.
Than we save other metadata, similar to [BibTex](https://en.wikipedia.org/wiki/BibTeX#Bibliographic_information_file).

# Arguments

- `url::String`: an link where one maybe can find the content in case the doi fails
- `author::String`: like in BibTex, e.g. "Peikert, Aaron and Ernst, Maximilian S. and Bode, Clifford"
- `date::Union{Date, Missing}`: optional date
- `year::Union{Int64}`: optional if date is supplied
- `journal::String`
- `other::Dict`: more BibTexlike metadata

```jldoctest; output = false
NoDOI(
    url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
    author = "Ernst, Maximilian Stefan and Peikert, Aaron",
    title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
    date = Date("2022-06-24"), # year is inferred
    journal = "No Real Journal",
    awesome = "Yes", # other metadata
    software = "naturally", # some more metadata
    citations = 500
)
NoDOI(
    url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
    author = "Ernst, Maximilian Stefan and Peikert, Aaron",
    title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
    year = 2022, # date is omitted
    journal = "No Real Journal"
)

# output

NoDOI("https://github.com/StructuralEquationModels/StructuralEquationModels.jl", "Ernst, Maximilian Stefan and Peikert, Aaron", "StructuralEquationModels.jl: A fast and flexible SEM framework", missing, 2022, "No Real Journal", Dict{Any, Any}())
```

"""
struct NoDOI <: AbstractDOI
    url::String
    author::String
    title::String
    date::Union{Date, Missing}
    year::Int64
    journal::String
    other::Dict
end

function NoDOI(;url, author, title, date = nothing, year = nothing, journal, kwargs...)
    if isnothing(date) && !isnothing(year)
        # only year supplied
        date = missing
    elseif !isnothing(date) && isnothing(year)
        # only date supplied
        year = Dates.year(date)
    else
        # both or neither supplied
        throw(ArgumentError("supply either date (prefered) or year"))
    end
    NoDOI(
        url,
        author,
        title, 
        date,
        year,
        journal,
        Dict(kwargs...)
    )
end
