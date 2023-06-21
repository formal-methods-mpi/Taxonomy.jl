"""
add dokumentation here!
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
