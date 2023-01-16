"""
Function to extract sample size.

## Arguments

- `x`: Something of type [`Taxon`](@ref)

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
rating(n_sample(f))

# output
100
```
"""
function n_sample(x::Taxon)
    x.n_sample
end



"""
Function to extract factor variance.

## Arguments

- `x`: Something of type [`Taxon`](@ref)

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
rating(factor_variance(f))

# output
1.0
```
"""
function factor_variance(x::Taxon)
    x.factor_variance
end
