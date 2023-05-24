abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
Taxon is the supertype of all taxons.
"""
abstract type Taxon end

abstract type AbstractPathmodel <: Taxon end
abstract type AbstractCFA <: Taxon end
abstract type LGCM <: Taxon end
abstract type CLPM <: Taxon end

struct Measurement <: AbstractCFA
    n_sample::Int64
end

function Standalone_Factor(;n_sample, kwargs...)
    Measurement(;n_sample = n_sample, kwargs...)
end

struct Structural <: AbstractPathmodel
    n_sample::Int64
end
    
function Manifest_Pathmodel(;n_sample, kwargs...)
    Strucutural(;n_sample = n_sample, kwargs...)
end


struct LatentPathmodel <: AbstractPathmodel 
    structural::Structural
    measurement::Measurement
end

struct BifactorCFA <: AbstractCFA 
    measurement::HierarchicalCFA
end

struct HierarchicalCFA <: AbstractCFA
    measurement::Measurement
end


struct CLPM <: AbstractPathmodel
    measurement::Measurement
end
struct LGCM <: AbstractPathmodel
    measurement::Measurement
end