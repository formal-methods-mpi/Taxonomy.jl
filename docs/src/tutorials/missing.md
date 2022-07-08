It is often the case that you can not code every information we would like to have.
Principly, you are not required to write anything:

```@meta
DocTestFilters = [r"May we suggest: .*", r"└ @ Taxonomy .*"]
```

```jldoctest missing
julia> using Taxonomy

julia> Record()
┌ Warning: You really should supply an ID. May we suggest: 6ca721fe-619e-42cc-ad8b-047c5e0451e5
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:14
┌ Warning: You really should supply a location.
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:19
┌ Warning: Some of the metadata seem to be incomplete. Check again.
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:25
┌ Warning: `taxons` is missing. Maybe you mean `NoTaxon()`?
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:29
┌ Warning: `spec` is missing. Maybe you mean `NoJudgment()`?
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:32
┌ Warning: `data` is missing. Maybe you mean `NoJudgment()`?
└ @ Taxonomy ~/work/Taxonomy.jl/Taxonomy.jl/src/record.jl:35
Record(missing, NoLocation(), IncompleteMeta(missing, missing, missing), missing, missing, missing)
```

```@meta
DocTestFilters = nothing
```

As you probably notice we warn you to do that.
This is to encourage you to think twice, however, after having thought twice about it, you may silence every warning with explicitly suppliyng "empty" instances (except ID, really nothing should hinder you to supply a random id).

```jldoctest missing
Record(id = "6ca721fe-619e-42cc-ad8b-047c5e0451e5",
location = NoLocation(),
meta = MetaData(missing, missing, missing),
taxons = [NoTaxon()],
spec = NoJudgement(),
data = NoJudgement())

# output

Record(UUID("6ca721fe-619e-42cc-ad8b-047c5e0451e5"), NoLocation(), IncompleteMeta(missing, missing, missing), [NoTaxon()], Judgement{Missing, Float64, Missing}(missing, 0.0, missing), Judgement{Missing, Float64, Missing}(missing, 0.0, missing))
```
We therefore differenciate between "lazy" missings and intentional missings.
The former remind you that you missed them, the latter will not bother you.

Another, unfortunately more complicated distinction, is between things you have tried to find out and determined that they probably are not accessable, and things that you havened made your mind up about.
We assume that missings in about metadata belong to the first category (you tried to find out, but could not) and that missings about judgements about the paper belong to the second category (you have not bothered to find out).
We make this distinction because you might that it takes to much time to find something out and want to express that you are not certain it exists.
But sometimes you have checked but it really does not exist.
E.g. at first glance you have not found a dataset, than use `NoJudgement()`.
It implies that you are absolutly uncertain that this is missing:

```jldoctest missing
julia> NoJudgement()
Judgement{Missing, Float64, Missing}(missing, 0.0, missing)
```

Or you have checked everywhere but there does not seem to be any data, than use:

```jldoctest missing
julia> Judgement(false, 1.0) # false = no data, 1 = certain
Judgement{Bool, Float64, Missing}(false, 1.0, missing)
```