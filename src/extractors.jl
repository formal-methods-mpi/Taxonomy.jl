"""
Function to extract sample size.

## Arguments

- `x`: Something of type [`Taxon`](@ref)

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4])
rating(n_sample(f))

# output
100
```
"""
function n_sample(x::Taxon)
    x.n_sample
end


