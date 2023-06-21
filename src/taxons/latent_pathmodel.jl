"""
Create a new `LatentPathmodel` instance.

for indexing:
my_model.structural_model.structural_model
my_model.measurement_model[:fac2]

```jldoctest
using StenoGraph
graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

my_model = LatentPathmodel(
    Structural(n_sample = 12, structural_model = graph),
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

using StenoGraph
graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

my_model = LatentPathmodel(
    Structural(n_sample = 12, structural_model = graph),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)
