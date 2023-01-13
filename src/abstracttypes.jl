abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
Taxon is the supertype of all taxons.
"""
abstract type Taxon end
abstract type AbstractCFA <: Taxon end
