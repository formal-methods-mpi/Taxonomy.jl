"""
Measurement AbstractCFA. 
Building Block for Taxonomy. Multiple Measurements can be combined to a Taxon. 

## Arguments

- `n_variables`: Number of variables (possibly observed/manifest). If items are parceled, this is the number of parcels.
- `loadings`: Vector of loadings, one for each item. 
- `factor_variance`: Variance of the factor.
- `error_variances`: Vector of variances of the respective errors
- `error_covariances_within`: Vector of covariances within factor.
- `error_covariances_between`: Vector of covariances the factor shares with a different factor. 
- `crossloadings_incoming`: Vector of crossloadings coming from other factors. They should be lower than the loading coming to the item from this factor.  
- `crossloadings_outgoing`: Vector of crossloadings going to other items which have higher loadings from other factors. 
- `quest_scale`: Scale of the questionnaire, can be either an integer,a float, or missing.

```jldoctest
Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6, quest_scale = 5)

# output

Measurement
   n_variables: JudgementInt{Int64}
   loadings: JudgementVecNumber{Vector{Float64}}
   factor_variance: JudgementNumber{Float64}
   error_variances: JudgementVecNumber{Missing}
   error_covariances_within: JudgementVecNumber{Missing}
   error_covariances_between: JudgementVecNumber{Missing}
   crossloadings_incoming: JudgementVecNumber{Missing}
   crossloadings_outgoing: JudgementVecNumber{Missing}
   quest_scale: JudgementInt{Int64}
```
"""
struct Measurement <: AbstractCFA
    n_variables::JudgementInt
    loadings::JudgementVecNumber
    factor_variance::JudgementNumber
    error_variances::JudgementVecNumber
    error_covariances_within::JudgementVecNumber
    error_covariances_between::JudgementVecNumber
    crossloadings_incoming::JudgementVecNumber
    crossloadings_outgoing::JudgementVecNumber
    quest_scale::Union{JudgementInt{Int64}, JudgementNumber{Float64}, Missing}
  end

    

function Measurement(j...;
    n_variables,
    loadings,
    factor_variance,
    error_variances=missing,
    error_covariances_within=missing,
    error_covariances_between=missing,
    crossloadings_incoming=missing,
    crossloadings_outgoing=missing,
    quest_scale=missing)

    # Convert quest_scale to JudgementInt or JudgementNumber if necessary
    quest_scale_converted = if isa(quest_scale, Int)
                                JudgementInt(quest_scale)  # Convert Int to JudgementInt
                            elseif isa(quest_scale, Float64)
                                JudgementNumber(quest_scale)  # Convert Float64 to JudgementNumber
                            else
                                quest_scale  # Keep as is (including Missing)
                            end

    Measurement(n_variables,
        loadings,
        factor_variance,
        error_variances,
        error_covariances_within,
        error_covariances_between,
        crossloadings_incoming,
        crossloadings_outgoing,
        quest_scale_converted)
end

"""
Standalone Factor Taxon. 
Taxon for Models with only one factor.

## Arguments

- `, kwargs...`: all other arguments are passed onto [`Measurement`](@ref)

"""
function StandaloneFactor(; kwargs...)
    Measurement(; kwargs...)
end

"""
Fixed{T <: Number}

A wrapper type for fixed parameters in a measurement model. The `Fixed` type is used to indicate that a certain numeric parameter, such as a factor variance or loading in a `Measurement`, is fixed. 

# Arguments
- `x::T`: The numeric value being wrapped as fixed.

# Usage
Use to indicate fixed parameters in a measurement model.
To create a fixed parameter, simply wrap the numeric value with `Fixed`. For example, `Fixed(1.0)` creates a fixed value of `1.0`.
The strip_fixed function is provided to extract the numeric value from a Fixed object. It can also handle regular numeric types, returning the value as is.

```jldoctest
fixed_loading = Fixed(0.7)

# output

Fixed{Float64}(0.7)
```
"""
struct Fixed{T <: Number} <: Number
    x::T
end
strip_fixed(x::Fixed) = x.x
strip_fixed(x::Number) = x

