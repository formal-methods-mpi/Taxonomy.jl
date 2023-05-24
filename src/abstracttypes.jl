abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
Taxon is the supertype of all taxons.
"""
abstract type Taxon end

abstract type AbstractPathmodel <: Taxon end
abstract type AbstractCFA <: Taxon end
abstract type AbstractLGCM <: Taxon end
abstract type AbstractCLPM <: Taxon end

struct Measurement <: AbstractCFA
    n_sample::Int64
end

function StandaloneFactor(;n_sample, kwargs...)
    Measurement(;n_sample = n_sample, kwargs...)
end

struct Structural <: AbstractPathmodel
    n_sample::Int64
end
    
function ManifestPathmodel(;n_sample, kwargs...)
    Strucutural(;n_sample = n_sample, kwargs...)
end


struct LatentPathmodel <: AbstractPathmodel 
    structural::Structural
    measurement::Measurement
end

struct HierarchicalCFA <: AbstractCFA
    measurement::Measurement
end

struct BifactorCFA <: AbstractCFA 
    measurement::HierarchicalCFA
end

struct SimpleCLPM <: Taxon
    measurement::Measurement
end

struct SimpleLGCM <: Taxon
    measurement::Measurement
end
