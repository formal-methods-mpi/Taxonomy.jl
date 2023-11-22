"""
Create a new `LatentPathmodel` instance.

for indexing:
my_model.structural_model.structural_model
my_model.measurement_model[:fac2]

```jldoctest
using StenoGraphs
graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

my_model = LatentPathmodel(
    Structural(structural_model = graph),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)

# output

LatentPathmodel
   structural_model: Structural
   measurement_model: Dict{Symbol, Measurement}
```
"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Dict{Symbol, Measurement}
end
