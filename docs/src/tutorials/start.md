The idea behind doing the coding in Julia is that we can automate two things.

1. We can enforce syntactical requirements with a quick feedback loop for the coder, resulting in less errors.
2. We can automatically infer much information, resulting in speedier and less error prone coding.

We implement these automation to detect error/misunderstanding/etc *while* coding and not long after.

To get a feeling for how this is supposed to work, we code the famous political democracy paper together:

```@meta
DocTestFilters = [r"\".*\"", r"May we suggest: .*", r"└ @ Taxonomy .*"]
```

```jldoctest first
using Taxonomy 
first_record = Record(
    rater = "AP",
    location = DOI("10.2307/2095172"),
    taxons = [StandaloneFactor(n_variables = 6, n_sample = 113, loadings = [1, 1.19, 0.53, 0.91, 1, 1], factor_variance = J(missing, 0.5), error_covariances_within = [10.7, 12.9, 19])],
    spec = true,
    data = true
)

# output

┌ Warning: You really should supply an ID. May we suggest (from DOI): 8f1713c9-482b-58cb-8ed4-128c03e9dafb
└ @ Taxonomy ~/Documents/remote/github/Taxonomy.jl/src/record.jl:19
Record
   rater: String
   id: Missing
   location: UsualDOI{String, Missing}
   meta: ExtensiveMeta{MinimalMeta}
   taxons: Vector{Factor}
   spec: Judgement{Bool}
   data: Judgement{Bool}

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
1-element Vector{Measurement}:
 Measurement
   n_sample: Judgement{Int64}
   n_variables: Judgement{Int64}
   loadings: Judgement{Vector{Float64}}
   factor_variance: Judgement{Missing}
   error_variances: Judgement{Int64}
   error_covariances_within: Judgement{Vector{Float64}}
   error_covariances_between: Judgement{Int64}
   crossloadings_incoming: Judgement{Int64}
   crossloadings_outgoing: Judgement{Int64}
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
    taxons = [Factor(n_variables = 6, loadings = [1, 1.19, 0.53, 0.91, 1, 1], error_covariances_within = [10.7, 12.9, 19])],
    spec = true,
    data = true
)
```