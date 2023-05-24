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

struct Measurement <: AbstractCFA end

struct Structural <: AbstractPathmodel end
    
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
