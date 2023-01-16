"""
LGCM Taxon. 
Taxon for Linear Growth Curve Model.

    ## Arguments

- `n_sample`: Number of observed cases.
- `timecoding`: Vector containing the coding of the measurement time points (loadings of the slope onto the items).
- `n_timepoints`: Number of measurement time points. Should normally be the length of timecoding.  
- `n_predictors`: Number of predictors for intercept and/or slope. 
- `non_linear_function`: If a nonlinear function is included, the respective slopes can be added here. 

```jldoctest
Factor(n_variables = 2, loadings = [1, 0.4])

# output
Factor(Judgement{Missing}(missing, 1.0, missing), Judgement{Int64}(2, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))
```
"""
struct LGCM <: Taxon
    n_sample::Judgement{ <: Union{ <:Int, Missing}}
    timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    ntimepoints::Judgement{ <: Union{ <: Int, Missing}}
    npredictors::Judgement{ <: Union{ <: Int, Missing}}
    nonlinearfunction::Judgement{ <: Union{ <: Int, Missing}}
    LGCM(n_sample, timecoding, ntimepoints, npredictors, nonlinearfunction) =
        new(J(n_sample), J(timecoding), J(ntimepoints), J(npredictors), J(nonlinearfunction))
end

function LGCM(; 
    n_sample = missing,
    timecoding = NoJudgement(), 
    ntimepoints = NoJudgement(),
    npredictors = 0,
    nonlinearfunction = 0)
    if !ismissing(rating(timecoding))
        implied_ntimepoints = length(rating(timecoding))
        if ismissing(rating(ntimepoints))
            ntimepoints = implied_ntimepoints
        end
        if ntimepoints != implied_ntimepoints
            throw(ArgumentError("ntimepoints does not aggree with ntimepoints"))
        end
    end
    
    LGCM(n_sample,
    timecoding, 
    ntimepoints, 
    npredictors, 
    nonlinearfunction
    )
end

