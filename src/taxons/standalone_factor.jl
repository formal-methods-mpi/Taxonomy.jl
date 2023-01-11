using Taxonomy
"""
Standalone Factor Taxon. 
Taxon for Models with only one factor.

## Arguments

- `nobserved`: Number of manifest variables.
- `n_sample`: Sample size.
- `loadings`: Vector of loadings, one for each item. 
- `error_covariances_within`: Vector of covariances within factor.

```jldoctest
Standalone_Factor(nobserved = 2, n_sample = 100, loadings = [1, 0.4])

# output
Standalone_Factor(Judgement{Int64}(2, 1.0, missing), Judgement{Int64}(100, 1.0, missing), Judgement{Vector{Float64}}([1.0, 0.4], 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing), Judgement{Int64}(0, 1.0, missing))```
"""

# Building block for coding the measurement model
struct Standalone_Factor <: AbstractCFA
     nobserved::Judgement{ <: Union{ <:Int, Missing}}
     n_sample::Judgement{ <: Union{ <:Int, Missing}}
     loadings::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     error_covariances_within::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    Standalone_Factor(nobserved, n_sample, loadings, error_covariances_within) =
        new(J(nobserved), J(n_sample), J(loadings), J(error_covariances_within))
end

function Standalone_Factor(;nobserved,
    n_sample, 
    loadings, 
    error_covariances_within = 0,
    Standalone_Factor(nobserved, n_sample, loadings, error_covariances_within)
end