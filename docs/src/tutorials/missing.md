It is often the case that you can not code every information we would like to have.
Principly, you are not required to write anything:

```@meta
DocTestFilters = [r"May we suggest: .*", r"└ @ Taxonomy .*"]
```

```jldoctest missing
julia> using Taxonomy

julia> Record()
┌ Warning: Please provide your rater ID. This should be your initials.
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/record.jl:16
┌ Warning: You really should supply an ID. May we suggest: e23f1ede-e271-4b4c-b692-7adc02f8d79e
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/record.jl:22
┌ Warning: You really should supply a location.
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/record.jl:27
┌ Warning: Some of the metadata seem to be incomplete. Check again.
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/record.jl:33
Record
   rater: Missing
   id: Missing
   location: NoLocation
   meta: IncompleteMeta
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}
```

As you probably notice we warn you to do that.
This is to encourage you to think twice, however, after having thought twice about it, you may silence every warning with explicitly suppliyng "empty" instances (except ID, really nothing should hinder you to supply a random id).

```jldoctest missing
Record(
   rater = "AP",
   id = "6ca721fe-619e-42cc-ad8b-047c5e0451e5",
   location = NoLocation(),
   meta = MetaData(missing, missing, missing),
   Study(Model(NoTaxon()))
)

# output
Record
   rater: String
   id: Base.UUID
   location: NoLocation
   meta: IncompleteMeta
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}
```

We therefore differenciate between "lazy" missings and intentional missings.
The former remind you that you missed them, the latter will not bother you.

Another, unfortunately more complicated distinction, is between things you have tried to find out and determined that they probably are not accessable, and things that you havened made your mind up about.
We assume that missings in about metadata belong to the first category (you tried to find out, but could not) and that missings about judgements about the paper belong to the second category (you have not bothered to find out).
We make this distinction because you might think that it takes to much time to find something out and want to express that you are not certain it exists.
But sometimes you have checked but it really does not exist.
E.g. at first glance you have not found a dataset, than use `NoJudgement()`.
It implies that you are absolutly uncertain that this is missing:

```jldoctest missing
julia> NoJudgement()
Judgement{Missing}(missing, 0.0, missing)
```

Or you have checked everywhere but there does not seem to be any data, than use:

```jldoctest missing
julia> Judgement(false, 1.0) # false = no data, 1 = certain
Judgement{Bool}(false, 1.0, missing)
```

If you want to highlight in the Record of a paper, that there is no model in the paper, that should be coded, use `NoTaxon()`.
If however you found a paper you were unable to code, due to limitations of the package or your own knowledge, hence you want to mark it to come back to it later, use `NoTaxonYet()`.This could look like this:

```jldoctest missing
Record(rater = "AP",
id = "6ca721fe-619e-42cc-ad8b-047c5e0451e5",
location = NoLocation(),
meta = MetaData(missing, missing, missing),
Study(Model(NoTaxonEver())))

# output

Record
   rater: String
   id: Base.UUID
   location: NoLocation
   meta: IncompleteMeta
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}
```

or like this:

```jldoctest missing
Record(rater = "AP",
id = "6ca721fe-619e-42cc-ad8b-047c5e0451e5",
location = NoLocation(),
meta = MetaData(missing, missing, missing),
Study(Model(NoTaxonYet("2023-06-06"))))

# output
┌ Warning: This model is currently not possible to code? - please come back later.
└ @ Taxonomy ~/Dokumente/GitHub/Taxonomy.jl/src/taxons/no_taxon.jl:34
Record
   rater: String
   id: Base.UUID
   location: NoLocation
   meta: IncompleteMeta
   judgements: Dict{Symbol, Vector{Union{Study, AbstractJudgement}}}
```

```@meta
DocTestFilters = nothing
```
