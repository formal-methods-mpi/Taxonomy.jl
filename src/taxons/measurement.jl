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
   n_sample: AbstractJudgement{Missing}
   n_variables: AbstractJudgement{Int64}
   loadings: AbstractJudgement{Vector{Float64}}
   factor_variance: AbstractJudgement{Float64}
   error_variances: AbstractJudgement{Int64}
   error_covariances_within: AbstractJudgement{Int64}
   error_covariances_between: AbstractJudgement{Int64}
   crossloadings_incoming: AbstractJudgement{Int64}
   crossloadings_outgoing: AbstractJudgement{Int64}
```
"""
struct Measurement <: AbstractCFA
    n_sample::AbstractJudgement{ <: Union{ <:Int, Missing}}
    n_variables::AbstractJudgement{ <: Union{ <:Int, Missing}}
    loadings::AbstractJudgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    factor_variance::AbstractJudgement{ <: Union{ <:Number, Missing}}
    error_variances::AbstractJudgement{<:Union{<:AbstractArray{<:Number},<: Int, Missing}}
    error_covariances_within::AbstractJudgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    error_covariances_between::AbstractJudgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    crossloadings_incoming::AbstractJudgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    crossloadings_outgoing::AbstractJudgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
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
StandaloneFactor(AbstractJudgement{Int64}(2, 1.0, missing), AbstractJudgement{Int64}(100, 1.0, missing), AbstractJudgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), AbstractJudgement{Int64}(0, 1.0, missing), AbstractJudgement{Int64}(0, 1.0, missing), AbstractJudgement{Int64}(0, 1.0, missing), AbstractJudgement{Int64}(0, 1.0, missing))```
"""
function StandaloneFactor(;n_sample, kwargs...)
    Measurement(;n_sample = n_sample, kwargs...)
end
