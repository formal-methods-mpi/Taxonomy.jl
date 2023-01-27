"""
LGCM Taxon. 
Taxon for Linear Growth Curve Model.

    ## Arguments

- `n_sample`: Number of observed cases.
- `n_timepoints`: Number of measurement timepoints.
- `timecoding`: Vector containing the coding of the measurement time points (loadings of the slope onto the timepoints).
- `nonlinear_timecoding`: Vector for the timecodings introduced by a nonlinear function. 
- `variance_intercept`: Variance of the intercept.
- `variance_slope`: Variance of the slope. 
- `covariance_intercept_slope`: Covariance between intercept and slope.
- `variances_timepoints`: Vector with variances of the timepoint variables. 
- `n_predictors`: Number of predictors on intercept and slope. 
- `predictor_paths_intercept`: Vector for the predictor-paths to the intercept.
- `predictor_paths_slope`: Vector for the predictor-paths to the slope.

```jldoctest
LGCM(n_sample = 500, timecoding = [0, 1, 2, 3, 4, 5], n_timepoints = 6, n_predictors = 2, nonlinear_timecoding = [0, 1, 4, 9, 16, 25])

# output
LGCM(Judgement{Int64}(500, 1.0, missing), Judgement{Vector{Int64}}([0, 1, 2, 3, 4, 5], 1.0, missing), Judgement{Int64}(6, 1.0, missing), Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Int64}}([0, 1, 4, 9, 16, 25], 1.0, missing))
```
"""
struct LGCM <: Taxon
    n_sample::Judgement{ <: Union{ <:Int, Missing}}
    n_timepoints::Judgement{ <: Union{ <:Int, Missing}}
    timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    nonlinear_timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    variance_intercept::Judgement{ <: Union{ <:Int, Missing}}
    variance_slope::Judgement{ <: Union{ <:Int, Missing}}
    covariance_intercept_slope::{Union{ <:Int, Missing}}
    variances_timepoints::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    n_predictors_intercept::Judgement{ <: Union{ <: Int, Missing}}
    predictor_paths_intercept::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    predictor_paths_slope::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    LGCM(n_sample, n_timepoints, timecoding, nonlinear_timecoding, variance_intercept, variance_slope, covariance_intercept_slope, variances_timepoints,  
    n_predictors, predictor_paths_intercept, predictor_paths_slope) =
        new(J(n_sample), J(n_timepoints), J(timecoding), J(covariance_intercept_slope), 
        J(nonlinear_timecoding), J(variance_intercept), J(variance_slope), J(covariance_intercept_slope), J(variances_timepoints), 
        J(n_predictors), J(predictor_paths_intercept), J(predictor_paths_slope))
end

function LGCM(; 
    n_sample,
    n_timepoints, 
    timecoding, 
    nonlinear_timecoding = 0,
    variance_intercept,
    variance_slope,
    covariance_intercept_slope = 0,
    variances_timepoints = 0,
    n_predictors = 0,
    predictor_paths_intercept = 0,
    predictor_paths_slope = 0
    
    LGCM(n_sample, n_timepoints, timecoding, nonlinear_timecoding, variance_intercept,
    variance_slope, covariance_intercept_slope, variances_timepoints, n_predictors,
    predictor_paths_intercept, predictor_paths_slope)
    )
end

