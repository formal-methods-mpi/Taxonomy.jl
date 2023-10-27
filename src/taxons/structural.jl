
"""
Structural AbstractPathmodel. 
Consists of a graph from StenoGraphs (structural model). 

## Arguments

- `structural_graph`: Graph from StenoGraphs package. Defines the latent relations between the factors of measurement_model.  

```julia-repl
using StenoGraphs

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

Structural(structural_graph = graph)
```
"""
struct Structural <: AbstractPathmodel
    n_sample::Judgement{<: Union{<: Int, Missing}}
    structural_graph::Judgement{ <: Union{<:AbstractArray{<: StenoGraphs.AbstractEdge}, Missing}}
    Structural(n_sample, structural_graph) = new(J(n_sample), J(structural_graph))
end

function Structural(;n_sample = missing,
    structural_graph)
    Structural(n_sample, structural_graph)
end


function ManifestPathmodel(;n_sample, kwargs...)
    Structural(;n_sample = n_sample, kwargs...)
end


