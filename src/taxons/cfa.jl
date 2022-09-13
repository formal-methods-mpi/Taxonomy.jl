"""
CFA Taxon. 

## Arguments

- `nmeasurement_model`: Number of latent variables.
- `nobserved`: Vector of manifest variables for each vector. 
- `nerror_covariances_within`: Vector of covariances within factor.
- `nerror_covariances_between`: Vector of covariances between measurement_model. 

```jldoc
julia> myfac1 = Factor(nobserved = 2, loadings = [1, 0.4])
myfac2 = Factor(nobserved = 2, loadings = [0.7, 0.3])

graph = @StenoGraph begin
    # latent regressions
    fac1 → fac2
end

CFA(measurement_model = [myfac1, myfac2], 
structural_model = graph )

```
"""

# Building block for coding the measurement model
struct Factor <: AbstractCFA
     nobserved::Judgement{ <: Union{ <:Int, Missing}}
     loadings::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
     error_covariances_within::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     error_covariances_between::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     crossloadings_incoming::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
     crossloadings_outgoing::Judgement{ <: Union{ <: AbstractArray{ <: Number}, <: Int, Missing}}
    Factor(nobserved, loadings, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing) =
        new(J(nobserved), J(loadings), J(error_covariances_within), J(error_covariances_between), J(crossloadings_incoming), J(crossloadings_outgoing))
end

function Factor(;nobserved,
    loadings, 
    error_covariances_within = 0,
    error_covariances_between = 0, 
    crossloadings_incoming = 0,
    crossloadings_outgoing = 0)
    Factor(nobserved, loadings, error_covariances_within, error_covariances_between, crossloadings_incoming, crossloadings_outgoing)
end

# Incorporate measurement model and structural model
struct CFA 
    measurement_model::Judgement{ <: Union{<:AbstractArray{<: Factor}, Missing}}
    structural_model::Judgement{ <: Union{<:AbstractArray{<: StenoGraphs.AbstractEdge}, Missing}}
    CFA(measurement_model, structural_model) = 
    new(J(measurement_model), J(structural_model))
end

function CFA(;measurement_model,
    structural_model) # hier basic CFA model festlegen
    CFA(measurement_model, structural_model)
end

