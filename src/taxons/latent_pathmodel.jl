"""
Taxon for Linear Growth Curve Model.
    function LatentPathmodel(;
        Structural(
            
        ),
        Measurement(
            n_sample = 100, 
            structural_model = structural_model_example,
            n_variables = 5,
            loadings = [0.7, 0.6, 0.8, 0.5, 0.9], 
            factor_variance = 1.0,
            error_variances = 0.05,
            error_covariances_within = 0,
            error_covariances_between = 0, 
            crossloadings_incoming = 0,
            crossloadings_outgoing = 0
    ))
    
    

Create a new `LatentPathmodel` instance.

# Examples

```jldoctest
julia> structural_model_example = Structural(...) # replace with actual example
julia> measurement_model_example = Measurement(...) # replace with actual example

julia> LatentPathmodel(
n_sample = 100, 
structural_model = structural_model_example,
n_variables = 5,
loadings = [0.7, 0.6, 0.8, 0.5, 0.9], 
factor_variance = 1.0,
error_variances = 0.05,
error_covariances_within = 0,
error_covariances_between = 0, 
crossloadings_incoming = 0,
crossloadings_outgoing = 0
)

# output

LatentPathmodel(structural_model_example, measurement_model_example)
"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Measurement
end

function LatentPathmodel(;
    structural = Structural(n_sample, structural_model),
    measurement = Measurement(
        n_sample = missing,
        n_variables,
        loadings, 
        factor_variance,
        error_variances = 0,
        error_covariances_within = 0,
        error_covariances_between = 0, 
        crossloadings_incoming = 0,
        crossloadings_outgoing = 0
        )
    LatentPathmodel(structural, measurement))
end