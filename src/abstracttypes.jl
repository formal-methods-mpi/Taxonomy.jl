abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
Taxon is the supertype of all taxons.
"""
#Can you see this?
abstract type Taxon end
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
Measurement AbstractCFA. 
Building Block for Taxonomy. Multiple Measurements can be combined to a Taxon. 

## Arguments

- `n_sample`: Number of observed cases. May be between different taxons from same paper sometime, e.g. multigroup models.
- `n_variables`: Number of variables (possibly observed/manifest).
- `loadings`: Vector of loadings, one for each item. 
- `factor_variance`: Variance of the factor.
- `error_variances`: Vector of variances of the respective errors
- `error_covariances_within`: Vector of covariances within factor.
- `error_covariances_between`: Vector of covariances the factor shares with a different factor. 
- `crossloadings_incoming`: Vector of crossloadings coming from other factors. They should be lower than the loading coming to the item from this factor.  
- `crossloadings_outgoing`: Vector of crossloadings going to other items which have higher loadings from other factors. 

```jldoctest
Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)

# output

Measurement
   n_sample: Judgement{Missing}
   n_variables: Judgement{Int64}
   loadings: Judgement{Vector{Float64}}
   factor_variance: Judgement{Float64}
   error_variances: Judgement{Int64}
   error_covariances_within: Judgement{Int64}
   error_covariances_between: Judgement{Int64}
   crossloadings_incoming: Judgement{Int64}
   crossloadings_outgoing: Judgement{Int64}
```
"""

struct Measurement <: AbstractCFA
    n_sample::Judgement{ <: Union{ <:Int, Missing}}
    n_variables::Judgement{ <: Union{ <:Int, Missing}}
    loadings::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    factor_variance::Judgement{ <: Union{ <:Number, Missing}}
    error_variances::Judgement{<:Union{<:AbstractArray{<:Number},<: Int, Missing}}
    error_covariances_within::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    error_covariances_between::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    crossloadings_incoming::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    crossloadings_outgoing::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    Measurement(n_sample, n_variables, loadings,factor_variance, error_variances, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing) =
        new(J(n_sample), J(n_variables), J(loadings), J(factor_variance), J(error_variances), J(error_covariances_within), J(error_covariances_between), J(crossloadings_incoming), J(crossloadings_outgoing))
end

function Measurement(;n_sample = missing,
    n_variables,
    loadings, 
    factor_variance,
    error_variances = 0,
    error_covariances_within = 0,
    error_covariances_between = 0, 
    crossloadings_incoming = 0,
    crossloadings_outgoing = 0)
    Measurement(n_sample, n_variables, loadings, factor_variance, error_variances, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing)
end

"""
Standalone Factor Taxon. 
Taxon for Models with only one factor.

## Arguments

- `nsample`: Sample size.
- `, kwargs...`: all other arguments are passed onto [`Measurement`](@ref)

All others

```jldoctest
StandaloneFactor(n_sample = 2, n_sample = 100, loadings = [1, 0.4])

# output
StandaloneFactor(Judgement{Int64}(2, 1.0, missing), Judgement{Int64}(100, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))```
"""

function StandaloneFactor(;n_sample, kwargs...)
    Measurement(;n_sample = n_sample, kwargs...)
end


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
LatentPathmodel AbstractPathmodel. 
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

LatentPathmodel(measurement_model = [factor1, factor2], 
structural_model = graph)

# output

LatentPathmodel
   n_sample: Judgement{Missing}
   measurement_model: Judgement{Vector{Measurement}}
   structural_model: Judgement{Vector{DirectedEdge{SimpleNode{Symbol}, SimpleNode{Symbol}}}}

```
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
