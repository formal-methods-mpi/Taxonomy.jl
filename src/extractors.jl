"""
Function to extract factor variance.

## Arguments

- `x`: [`Measurement`](@ref) or [`Standalone_Factor`](@ref).

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
rating(factor_variance(f))

# output
1.0
```
"""
factor_variance(x::Measurement) = x.factor_variance

"""
Function to extract the `StenoGraphs` structural model from [`Structural`].

## Arguments

- `x`: [`Strucutral`](@ref).

## Return

Returns a [`Judgement`](@ref)

```julia-repl
using Taxonomy
using StenoGraphs

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

struct_model = Structural(structural_model = graph)

structural_model(struct_model)
```
"""
structural_model(x::Structural) = x.structural_model

"""
Function to extract a Judgement from a `JudgementLevel` (e.g. [Model](@ref), [Record](@ref), [Study](@ref)).

## Return

Returns a [`Judgement`](@ref)

```doctest
using Taxonomy

record = Record(
   rater = "AP",
   id = "6ca721fe-619e-42cc-ad8b-047c5e0451e5",
   location = NoLocation(),
   meta = MetaData(missing, missing, missing),
   Lang("de")
)

judgements(record)

# output

Dict{Symbol, Vector{Union{Study, AbstractJudgement}}} with 1 entry:
  :Lang => [Lang{String}("de", 1.0, missing)]
```
"""
judgements(x::JudgementLevel) = x.judgements
url(x::Record) = url(location(x))
url(x::RecordDatabase) = map(x -> url(x.second), collect(x))

Base.get(r::JudgementLevel, field::Symbol, default=Vector{Union{JudgementLevel,AbstractJudgement}}[]) = get(judgements(r), field, default)

"""
Extract all `Studies` from a `Record`. 
"""
Study(r::Record)::Vector{Union{Study,AbstractJudgement}} = get(judgements(r), :Study, [])
Study(r::Dict{Symbol,Vector{Union{Study,AbstractJudgement}}})::Vector{Union{Study,AbstractJudgement}} = get(r, :Study, [])

"""
Extract all `Models` from a `Study`. 
"""
Model(s::Study)::Vector{Union{Model,AbstractJudgement}} = get(judgements(s), :Model, [])

"""
Extract all Taxons from a Model.
"""
Taxon(m::Model)::Vector{Union{Taxon,AbstractJudgement}} = get(judgements(m), :Taxon, [])

"""
Extract Measurement part from a Taxon. 
"""
measurement_model(t::Taxon) = t.measurement_model

"""
Extract Structural part from a Taxon. 
"""
structural_model(t::Taxon) = t.structural_model
