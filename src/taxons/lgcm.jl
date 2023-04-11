"""
LGCM Taxon. 
Taxon for Linear Growth Curve Model.

    ## Arguments

- `n_sample`: Number of observed cases.
- `n_timepoints`: Number of measurement timepoints.
- `timecoding`: Vector containing the coding of the measurement time points (loadings of the slope onto the timepoints).
- `intercept`: Intercept constant.
- `slope`: Slope constant. 
- `nonlinear_timecoding`: Vector for the timecodings introduced by a nonlinear function. 
- `variance_intercept`: Variance of the intercept.
- `variance_slope`: Variance of the slope. 
- `covariance_intercept_slope`: Covariance between intercept and slope.
- `variances_timepoints`: Vector with variances of the timepoint variables. 
- `n_predictors`: Number of predictors on intercept and slope. 
- `predictor_paths_intercept`: Vector for the predictor-paths to the intercept.
- `predictor_paths_slope`: Vector for the predictor-paths to the slope.

```jldoctest
LGCM(n_sample = 500, n_timepoints = 6, timecoding = [0, 1, 2, 3, 4, 5], intercept = 10.2, 
slope = 0.96, nonlinear_timecoding = [1, 2, 4, 9, 16, 25], variance_intercept = 1, variance_slope = 1, covariance_intercept_slope = 0.1,
n_predictors = 2, predictor_paths_intercept = [2, 4], predictor_paths_slope = [3, 5])

# output
LGCM(Judgement{Int64}(500, 1.0, missing), Judgement{Int64}(6, 1.0, missing), Judgement{Vector{Int64}}([0, 1, 2, 3, 4, 5], 1.0, missing), Judgement{Float64}(10.2, 1.0, missing), Judgement{Float64}(0.96, 1.0, missing), Judgement{Vector{Int64}}([1, 2, 4, 9, 16, 25], 1.0, missing), Judgement{Int64}(1, 1.0, missing), Judgement{Int64}(1, 1.0, missing), Judgement{Float64}(0.1, 1.0, missing), Judgement{Missing}(missing, 1.0, missing), Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Int64}}([2, 4], 1.0, missing), Judgement{Vector{Int64}}([3, 5], 1.0, missing))
```
"""
struct LGCM <: Taxon
    n_sample::Judgement{ <: Union{ <:Int, Missing}}
    n_timepoints::Judgement{ <: Union{ <:Int, Missing}}
    timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    intercept::Judgement{ <: Union{ <:Number, Missing}}
    slope::Judgement{ <: Union{ <:Number, Missing}}
    nonlinear_timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    variance_intercept::Judgement{ <: Union{ <:Number, Missing}}
    variance_slope::Judgement{ <: Union{ <:Number, Missing}}
    covariance_intercept_slope::Judgement{ <: Union{ <:Number, Missing}}
    variances_timepoints::Judgement{ <: Union{ <:Number, Missing}}
    n_predictors_intercept::Judgement{ <: Union{ <: Int, Missing}}
    predictor_paths_intercept::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    predictor_paths_slope::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    LGCM(n_sample, n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope, covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope) =
        new(J(n_sample), J(n_timepoints), J(timecoding), J(intercept), J(slope), J(nonlinear_timecoding), J(variance_intercept), J(variance_slope), J(covariance_intercept_slope), J(variances_timepoints), J(n_predictors), J(predictor_paths_intercept), J(predictor_paths_slope))
end

function LGCM(; 
    n_sample = missing,
    n_timepoints, 
    timecoding, 
    intercept = missing,
    slope = missing,
    nonlinear_timecoding = 0,
    variance_intercept = missing,
    variance_slope = missing,
    covariance_intercept_slope = 0,
    variances_timepoints = missing, 
    n_predictors = 0,
    predictor_paths_intercept = 0,
    predictor_paths_slope = 0)
   
    LGCM(n_sample, n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope, covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope)
end


## Extractors --------
"""
Extract number of timepoints from LGCM.
"""
n_timepoints(x::LGCM) = x.n_timepoints

"""
Extract timecoding from LGCM.
"""
timecoding(x::LGCM) = x.timecoding

"""
Extract intercept from LGCM.
"""
intercept(x::LGCM) = x.intercept

"""
Extract slope from LGCM.
"""
slope(x::LGCM) = x.slope

"""
Extract nonlinear_timecoding from LGCM.
"""
nonlinear_timecoding(x::LGCM) = x.nonlinear_timecoding

"""
Extract variance of the intercept from LGCM.
"""
variance_intercept(x::LGCM) = x.variance_intercept

"""
Extract variance of the slope from LGCM.
"""
variance_slope(x::LGCM) = x.variance_slope

"""
Extract the covariance of the intercept and slope from LGCM.
"""
covariance_intercept_slope(x::LGCM) = x.covariance_intercept_slope

"""
Extract the variance of the timepoints from LGCM.
"""
variance_timepoints(x::LGCM) = x.variances_timepoints

"""
Extract the number of predictors from LGCM.
"""
n_predictors(x::LGCM) = x.n_predictors

"""
Extract the predictor-paths for the intercept from LGCM.
"""
predictor_paths_intercept(x::LGCM) = x.predictor_paths_intercept

"""
Extract the predictor-paths for the slope from LGCM.
"""
predictor_paths_slope(x::LGCM) = x.predictor_paths_slope







