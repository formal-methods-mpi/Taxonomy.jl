"""
SimpleLGCM AbstractLGCM. 
Taxon for Linear Growth Curve Model.

    ## Arguments
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
SimpleLGCM(n_timepoints = 6, timecoding = [0, 1, 2, 3, 4, 5], intercept = 10.2, 
slope = 0.96, nonlinear_timecoding = [1, 2, 4, 9, 16, 25], variance_intercept = 1, variance_slope = 1, covariance_intercept_slope = 0.1,
n_predictors = 2, predictor_paths_intercept = [2, 4], predictor_paths_slope = [3, 5])

# output
SimpleLGCM
   n_timepoints: JudgementInt{Int64}
   timecoding: JudgementVecNumber{Vector{Int64}}
   intercept: JudgementNumber{Float64}
   slope: JudgementNumber{Float64}
   nonlinear_timecoding: JudgementVecNumber{Vector{Int64}}
   variance_intercept: JudgementNumber{Int64}
   variance_slope: JudgementNumber{Int64}
   covariance_intercept_slope: JudgementNumber{Float64}
   variances_timepoints: JudgementNumber{Missing}
   n_predictors: JudgementInt{Int64}
   predictor_paths_intercept: JudgementVecNumber{Vector{Int64}}
   predictor_paths_slope: JudgementVecNumber{Vector{Int64}}
```
"""
struct SimpleLGCM <: AbstractLGCM
    n_timepoints::JudgementInt
    timecoding::JudgementVecNumber
    intercept::JudgementNumber
    slope::JudgementNumber
    nonlinear_timecoding::JudgementVecNumber
    variance_intercept::JudgementNumber
    variance_slope::JudgementNumber
    covariance_intercept_slope::JudgementNumber
    variances_timepoints::JudgementNumber
    n_predictors::JudgementInt
    predictor_paths_intercept::JudgementVecNumber
    predictor_paths_slope::JudgementVecNumber
end

function SimpleLGCM(; 
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
   
    SimpleLGCM(n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope, covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope)
end


## Extractors --------
"""
Extract number of timepoints from LGCM.
"""
n_timepoints(x::SimpleLGCM) = x.n_timepoints

"""
Extract timecoding from LGCM.
"""
timecoding(x::SimpleLGCM) = x.timecoding

"""
Extract intercept from LGCM.
"""
intercept(x::SimpleLGCM) = x.intercept

"""
Extract slope from LGCM.
"""
slope(x::SimpleLGCM) = x.slope

"""
Extract nonlinear_timecoding from LGCM.
"""
nonlinear_timecoding(x::SimpleLGCM) = x.nonlinear_timecoding

"""
Extract variance of the intercept from LGCM.
"""
variance_intercept(x::SimpleLGCM) = x.variance_intercept

"""
Extract variance of the slope from LGCM.
"""
variance_slope(x::SimpleLGCM) = x.variance_slope

"""
Extract the covariance of the intercept and slope from LGCM.
"""
covariance_intercept_slope(x::SimpleLGCM) = x.covariance_intercept_slope

"""
Extract the variance of the timepoints from LGCM.
"""
variances_timepoints(x::SimpleLGCM) = x.variances_timepoints

"""
Extract the number of predictors from LGCM.
"""
n_predictors(x::SimpleLGCM) = x.n_predictors

"""
Extract the predictor-paths for the intercept from LGCM.
"""
predictor_paths_intercept(x::SimpleLGCM) = x.predictor_paths_intercept

"""
Extract the predictor-paths for the slope from LGCM.
"""
predictor_paths_slope(x::SimpleLGCM) = x.predictor_paths_slope







