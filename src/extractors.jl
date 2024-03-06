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
function factor_variance(x::Measurement)
    x.factor_variance
end


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
function structural_model(x::Structural)
    x.structural_model
end



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




"""
Function to extract all studies from [RecordDatabase](@ref) or [Record](@ref). 

## Returns a vector of type Vector{Study} with all studies in the database or record. 
"""
extract_studies(r::Record) = r.judgements[:Study]
function extract_studies(r::RecordDatabase) 
    study_vec = []
    for i in values(r)
        push!(study_vec, extract_studies(i)...) # what if i contains multiple studies?
    end
    return study_vec
end


