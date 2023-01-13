"""
Standalone Factor Taxon. 
Taxon for Models with only one factor.

## Arguments

- `nsample`: Sample size.
- `, kwargs...`: all other arguments are passed onto [`Factor`](@ref)

All others

```jldoctest
Standalone_Factor(n_sample = 2, n_sample = 100, loadings = [1, 0.4])

# output
Standalone_Factor(Judgement{Int64}(2, 1.0, missing), Judgement{Int64}(100, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))```
"""
function Standalone_Factor(;n_sample, kwargs...)
    Factor(;n_sample = n_sample, kwargs...)
end