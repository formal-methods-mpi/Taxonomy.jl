"""
add dokumentation here!
"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Measurement
end

function LatentPathmodel(;
    structural_model,
    measurement_model)
    LatentPathmodel(structural_model, measurement_model)
end