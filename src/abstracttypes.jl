abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
Taxon is the supertype of all taxons.
"""
#Can you see this?
abstract type Taxon end
"""
NoTaxon is the supertype for not exiting Taxons (yet)
"""
abstract type NoTaxon <: Taxon end

"""
AbstractPathmodel is the supertype of all pathmodels.
"""
abstract type AbstractPathmodel <: Taxon end
"""
AbstractCFA is the supertype of all CFAs.
"""
abstract type AbstractCFA <: Taxon end
abstract type AbstractLGCM <: Taxon end
abstract type AbstractCLPM <: Taxon end

"""
Structural Taxon. 
Consists of a graph from StenoGraphs structural (structural model) and a measurement (measurement model). 

## Arguments

- `structural_model`: Graph from StenoGraphs package. Defines the latent relations between the factors of measurement_model.  
- `measurement_model`: Vector of Factors.

```julia
using StenoGraphs
using Taxonomy

factor1 = Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.7)
factor2 = Measuremnt(n_variables = 2, loadings = [0.7, 0.3], factor_variance = 1)

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

Structural(measurement_model = [factor1, factor2], 
structural_model = graph)

# output

LatentPathmodel
   n_sample: Judgement{Missing}
   measurement_model: Judgement{Vector{Measurement}}
   structural_model: Judgement{Vector{DirectedEdge{SimpleNode{Symbol}, SimpleNode{Symbol}}}}

```
"""
struct Structural <: AbstractPathmodel
    n_sample::Int64
    measurement_model::Judgement{ <: Union{<:AbstractArray{<: Factor}, Missing}}
    structural_model::Judgement{ <: Union{<:AbstractArray{<: StenoGraphs.AbstractEdge}, Missing}}
    Structural(n_sample, measurement_model, structural_model) = new(J(n_sample), J(measurement_model), J(structural_model))
end

function Structural(;n_sample = missing,
    measurement_model,
    structural_model) # hier basic CFA model festlegen
    Structural(n_sample, measurement_model, structural_model)
end


function ManifestPathmodel(;n_sample, kwargs...)
    Strucutural(;n_sample = n_sample, kwargs...)
end

"""
add dokumentation here!
"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Measurement
end

struct HierarchicalCFA <: AbstractCFA
    measurement_model::Measurement
end

struct BifactorCFA <: AbstractCFA 
    measurement_model::HierarchicalCFA
end

struct SimpleCLPM <: AbstractCLPM
    measurement_model::Measurement
end

struct SimpleLGCM <: AbstractLGCM
    measurement_model::Measurement
end
