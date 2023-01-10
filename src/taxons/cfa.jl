using StenoGraphs

"""
Factor Taxon. 
Building Block for CFA Taxonomy. Multiple Factors can be combined to a CFA. 

## Arguments

- `nobserved`: Number of manifest variables.
- `loadings`: Vector of loadings, one for each item. 
- `factor_variance`: Variance of the factor.
- `error_covariances_within`: Vector of covariances within factor.
- `error_covariances_between`: Vector of covariances the factor shares with a different factor. 
- `crossloadings_incoming`: Vector of crossloadings coming from other factors. They should be lower than the loading coming to the item from this factor.  
- `crossloadings_outgoing`: Vector of crossloadings going to other items which have higher loadings from other factors. 

```jldoctest
Factor(nobserved = 2, loadings = [1, 0.4], factor_variance = 0.6)

# output
Factor(Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Float64}(0.6, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))
```
"""

# Building block for coding the measurement model
struct Factor <: AbstractCFA
     nobserved::Judgement{ <: Union{ <:Int, Missing}}
     loadings::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     factor_variance::Judgement{ <: Union{ <:Number, Missing}}
     error_covariances_within::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     error_covariances_between::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     crossloadings_incoming::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     crossloadings_outgoing::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    Factor(nobserved, loadings, factor_variance, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing) =
        new(J(nobserved), J(loadings), J(factor_variance), J(error_covariances_within), J(error_covariances_between), J(crossloadings_incoming), J(crossloadings_outgoing))
end

function Factor(;nobserved,
    loadings, 
    factor_variance,
    error_covariances_within = 0,
    error_covariances_between = 0, 
    crossloadings_incoming = 0,
    crossloadings_outgoing = 0)
    Factor(nobserved, loadings, factor_variance, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing)
end


"""
CFA Taxon. 
Consists of Factors (measurement model) and a graph from StenoGraphs (structural model). 

## Arguments

- `measurement_model`: Vector of Factors.
- `structural_model`: Graph from StenoGraphs package. Defines the latent relations between the factors of measurement_model.  

```jldoctest
using StenoGraphs
using Taxonomy

factor1 = Factor(nobserved = 2, loadings = [1, 0.4], factor_variance = 0.7)
factor2 = Factor(nobserved = 2, loadings = [0.7, 0.3], factor_variance = 1)

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

CFA(measurement_model = [factor1, factor2], 
structural_model = graph )

# output
CFA(Judgement{Vector{Factor}}(Factor[Factor(Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Float64}(0.7, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing)), Factor(Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Float64}}([0.7, 0.3], 1.0, missing), Judgement{Int64}(1, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))], 1.0, missing), Judgement{Vector{DirectedEdge{SimpleNode{Symbol}, SimpleNode{Symbol}}}}(fac1 → fac2
, 1.0, missing))
```
"""
struct CFA 
    measurement_model::Judgement{ <: Union{<:AbstractArray{<: Factor}, Missing}}
    structural_model::Judgement{ <: Union{<:AbstractArray{<: StenoGraphs.AbstractEdge}, Missing}}
    CFA(measurement_model, structural_model) = 
    new(J(measurement_model), J(structural_model))
end

function CFA(;measurement_model,
    structural_model) # hier basic CFA model festlegen
    CFA(measurement_model, structural_model)
end

