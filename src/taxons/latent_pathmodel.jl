"""
add dokumentation here!
"""
struct LatentPathmodel <: AbstractPathmodel 
    structural_model::Structural
    measurement_model::Measurement
end
