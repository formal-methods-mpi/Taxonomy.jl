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
    Study(Model(StandaloneFactor(
        n_variables = 6, 
        loadings = [1, 1.19, 0.53, 0.91, 1, 1], 
        factor_variance = J(missing, 0.5), 
        error_covariances_within = [10.7, 12.9, 19])))
)

# output
┌ Warning: You really should supply an ID. May we suggest (from DOI): 8f1713c9-482b-58cb-8ed4-128c03e9dafb
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/record.jl:20
Record
   rater: String
   id: Missing
   location: UsualDOI{String, Missing}
   meta: ExtensiveMeta{MinimalMeta}
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}

```

```@meta
DocTestFilters = nothing
```

```jldoctest first
julia> year(first_record)
1980
julia> apa(first_record)
"Bollen, K. A. (1980). Issues in the Comparative Measurement of Political Democracy. American Sociological Review, 45(3), 370. https://doi.org/10.2307/2095172\n"
julia> ExtractStudy(first_record)[1].judgements[:Model][1].judgements[:Taxon][1]
Measurement
   n_variables: JudgementInt{Int64}
   loadings: JudgementVecNumber{Vector{Float64}}
   factor_variance: JudgementNumber{Missing}
   error_variances: JudgementVecNumber{Missing}
   error_covariances_within: JudgementVecNumber{Vector{Float64}}
   error_covariances_between: JudgementVecNumber{Missing}
   crossloadings_incoming: JudgementVecNumber{Missing}
   crossloadings_outgoing: JudgementVecNumber{Missing}
   quest_scale: JudgementInt{Missing}
```

Generally, DOIs are the best and easiest thing to get metadata, however, sometimes none is availible:

``` jldoctest NoDOI
using Taxonomy
Record(
    rater = "AP", 
    id = "96ac4220-45d2-43ca-930d-afb67763f56f", # ID gets recommended by the function.
    location = NoDOI(
        url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
        author = "Ernst, Maximilian Stefan and Peikert, Aaron",
        title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
        year = 2022, # date is omitted
        journal = "No Real Journal"
    ),
    Study(Model(StandaloneFactor(
        n_variables = 6, 
        loadings = [1, 1.19, 0.53, 0.91, 1, 1], 
        factor_variance = J(missing, 0.5), 
        error_covariances_within = [10.7, 12.9, 19])))
)

# output
Record
   rater: String
   id: Base.UUID
   location: NoDOI
   meta: MinimalMeta
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}
```