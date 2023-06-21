"""
Taxon for Linear Growth Curve Model.
    function LatentPathmodel(;
        Structural(structural_model = graph),
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
using StenoGraph

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end


LatentPathmodel(
    Structural(structural_model = graph),
    Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6))

# output

LatentPathmodel
    Structural: Structural
    Measurement: Measurement
    
n_sample: Judgement{Missing}
    structural_model: Judgement{Vector{DirectedEdge{SimpleNode{Symbol}, SimpleNode{Symbol}}}}



"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Measurement
end


function LatentPathmodel(;
    n_sample = missing, 
    structural_model,
    n_variables,
    loadings, 
    factor_variance,
    error_variances = 0,
    error_covariances_within = 0,
    error_covariances_between = 0, 
    crossloadings_incoming = 0,
    crossloadings_outgoing = 0
    )
    structural = Structural(n_sample = n_sample, structural_model = structural_model)
    measurement = Measurement(
    n_sample = n_sample, 
    n_variables = n_variables,
    loadings = loadings, 
    factor_variance = factor_variance,
    error_variances = error_variances,
    error_covariances_within = error_covariances_within,
    error_covariances_between = error_covariances_between,
    crossloadings_incoming = crossloadings_incoming,
    crossloadings_outgoing = crossloadings_outgoing
    )
    LatentPathmodel(structural, measurement)
end


using Taxonomy
using StenoGraphs

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

LatentPathmodel(
    Structural(n_sample = 12, structural_model = graph),
    Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6))