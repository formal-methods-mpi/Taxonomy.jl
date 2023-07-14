"""
Function to extract sample size.

## Arguments

- `x`: Something of type [`Taxon`](@ref)

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Measurement(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
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

- `x`: [`Measurement`](@ref) or [`Standalone_Factor`](@ref).

## Return

Returns a [`Judgement`](@ref)

```jldoctest
f = Measurement(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
rating(factor_variance(f))

# output
1.0
```
"""
function factor_variance(x::Measurement)
    x.factor_variance
end


"""
Function to extract the `StenoGraphs` structural model from [`Structural`].

## Arguments

- `x`: [`Strucutral`](@ref).

## Return

Returns a [`Judgement`](@ref)

```julia-repl
using Taxonomy
using StenoGraphs

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

struct_model = Structural(structural_graph = graph)

structural_graph(struct_model)
```
"""
function structural_graph(x::Structural)
    x.structural_graph
end
