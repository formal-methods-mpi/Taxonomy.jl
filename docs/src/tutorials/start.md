The idea behind doing the coding in Julia is that we can automate two things.

1. We can enforce syntactical requirements with a quick feedback loop for the coder, resulting in less errors.
2. We can automatically infer much information, resulting in speedier and less error prone coding.

We implement these automation to detect error/misunderstanding/etc *while* coding and not long after.

To get a feeling for how this is supposed to work, we code the famous political democracy paper together:

```@meta
DocTestFilters = [r"\".*\"", r"May we suggest: .*", r"└ @ Taxonomy .*"]
```

```jldoctest first; output = false
using Taxonomy 
first_record = Record(
    location = DOI("10.2307/2095172"),
    taxons = [GFactor(nobserved = 6, nerror_covariances = 3)],
    spec = true,
    data = true
)

# output

┌ Warning: You really should supply an ID. May we suggest (from DOI): 8f1713c9-482b-58cb-8ed4-128c03e9dafb
└ @ Taxonomy ~/Documents/remote/github/Taxonomy.jl/src/record.jl:15
Record(missing, UsualDOI{String, Missing}("10.2307/2095172", missing), ExtensiveMeta{MinimalMeta}(MinimalMeta("Bollen, Kenneth A.", 1980, "American Sociological Review"), "Bollen, K. A. (1980). Issues in the Comparative Measurement of Political Democracy. American Sociological Review, 45(3), 370. https://doi.org/10.2307/2095172\n", Dict{String, Any}("publisher" => "SAGE Publications", "member" => "179", "issue" => "3", "indexed" => Dict{String, Any}("date-parts" => Any[Any[2022, 7, 20]], "date-time" => "2022-07-20T10:04:48Z", "timestamp" => 1658311488831), "reference-count" => 0, "container-title-short" => "American Sociological Review", "issued" => Dict{String, Any}("date-parts" => Any[Any[1980, 6]]), "container-title" => "American Sociological Review", "subject" => Any["Sociology and Political Science"], "resource" => Dict{String, Any}("primary" => Dict{String, Any}("URL" => "http://www.jstor.org/stable/2095172?origin=crossref"))…)), GFactor[GFactor(Judgement{Int64}(6, 1.0, missing), Judgement{Int64}(3, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))], Judgement{Bool}(true, 1.0, missing), Judgement{Bool}(true, 1.0, missing))

```

```@meta
DocTestFilters = nothing
```

```jldoctest first
julia> year(first_record)
1980
julia> apa(first_record)
"Bollen, K. A. (1980). Issues in the Comparative Measurement of Political Democracy. American Sociological Review, 45(3), 370. https://doi.org/10.2307/2095172\n"
julia> spec(first_record)
Judgement{Bool}(true, 1.0, missing)
julia> taxons(first_record)
1-element Vector{GFactor}:
 GFactor(Judgement{Int64}(6, 1.0, missing), Judgement{Int64}(3, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))
```

Generally, DOIs are the best and easiest thing to get metadata, however, sometimes none is availible:

```
Record(
    location = NoDOI(
        url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
        author = "Ernst, Maximilian Stefan and Peikert, Aaron",
        title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
        year = 2022, # date is omitted
        journal = "No Real Journal"
    ),
    taxons = [GFactor(nobserved = 6, nerror_covariances = 3)],
    spec = true,
    data = true
)
```