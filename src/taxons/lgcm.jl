using Taxonomy
"""
LGCM Taxon. 
Taxon for Linear Growth Curve Model.

    ## Arguments

- `n_sample`: Number of observed cases.
- `timecoding`: Vector containing the coding of the measurement time points (loadings of the slope onto the items).
- `n_timepoints`: Number of measurement time points. Should normally be the length of timecoding.  
- `n_predictors`: Number of predictors for intercept and/or slope. 
- `non_linear_function`: Vector for including the slopes introduced by a nonlinear function.  

```jldoctest
LGCM(n_sample = 500, timecoding = [0, 1, 2, 3, 4, 5], n_timepoints = 6, n_predictors = 2, non_linear_function = [0, 1, 4, 9, 16, 25])

# output
LGCM(Judgement{Int64}(500, 1.0, missing), Judgement{Vector{Int64}}([0, 1, 2, 3, 4, 5], 1.0, missing), Judgement{Int64}(6, 1.0, missing), Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Int64}}([0, 1, 4, 9, 16, 25], 1.0, missing))
```
"""
struct LGCM <: Taxon
    n_sample::Judgement{ <: Union{ <:Int, Missing}}
    timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    n_timepoints::Judgement{ <: Union{ <: Int, Missing}}
    n_predictors::Judgement{ <: Union{ <: Int, Missing}}
    non_linear_function::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    LGCM(n_sample, timecoding, n_timepoints, n_predictors, non_linear_function) =
        new(J(n_sample), J(timecoding), J(n_timepoints), J(n_predictors), J(non_linear_function))
end

function LGCM(; 
    n_sample = missing,
    timecoding = NoJudgement(), 
    n_timepoints = NoJudgement(),
    n_predictors = 0,
    non_linear_function = NoJudgement())
    if !ismissing(rating(timecoding))
        implied_n_timepoints = length(rating(timecoding))
        if ismissing(rating(n_timepoints))
            n_timepoints = implied_n_timepoints
        end
        if n_timepoints != implied_n_timepoints
            throw(ArgumentError("ntimepoints does not aggree with ntimepoints"))
        end
    end
    
    LGCM(n_sample,
    timecoding, 
    n_timepoints, 
    n_predictors, 
    non_linear_function
    )
end

