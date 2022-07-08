"""
What to do if there is no doi

Last resort if there is no DOI.
Than we save other metadata, similar to [BibTex](https://en.wikipedia.org/wiki/BibTeX#Bibliographic_information_file).

# Arguments

- `url::String`: an link where one maybe can find the content in case the doi fails
- `author::String`: like in BibTex, e.g. "Peikert, Aaron and Ernst, Maximilian S. and Bode, Clifford"
- `date::Union{Date, Missing}`: optional date
- `year::Union{Int64}`: optional if date is supplied
- `journal::String`: The outlet of the publication
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
struct NoDOI <: AbstractLocation
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


"""
When everything fails.

This is a placeholder if really no location can be found.
"""
struct NoLocation <: AbstractLocation end

"""
Get URL from location.

```jldoctest
julia> url(DOI("10.1126/SCIENCE.169.3946.635"))
"https://doi.org/10.1126/SCIENCE.169.3946.635"
```

```jldoctest
location = NoDOI(
    url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
    author = "Ernst, Maximilian Stefan and Peikert, Aaron",
    title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
    year = 2022, # date is omitted
    journal = "No Real Journal"
)

url(location)

# output

"https://github.com/StructuralEquationModels/StructuralEquationModels.jl"
```
"""
url(x::T) where {T <: AbstractLocation} = missing
url(x::NoDOI) = x.url
