
"""
Structural AbstractPathmodel. 
Consists of a graph from StenoGraphs (structural model). 

## Arguments

- `structural_model`: Graph from StenoGraphs package. Defines the latent relations between the factors of measurement_model.  

```julia-repl
using StenoGraphs

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

Structural(structural_model = graph)
```
"""
struct Structural <: AbstractPathmodel
    structural_model::AbstractJudgement{ <: Union{<:AbstractArray{<: StenoGraphs.AbstractEdge}, Missing}}
    Structural(structural_model) = new(J(structural_model))
end

function Structural(;structural_model) # hier basic CFA model festlegen
    Structural(structural_model)
end


function ManifestPathmodel(;kwargs...)
    Structural(;kwargs...)
end
