abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
"""
A judgment about something. All judgments should return:

- `rating`: The rating, e.g. "Structural" or 1.0.
- `certainty`: If uncertain, a number between 0.0 and 1.0 (0-100%)
- `location`: optional, where in the Paper PDF was the location retieved, e.g. section, page, table number, figure number or a quote.

```jldoctest
julia> Judgement(1.0, .99, "Figure 1");
```

"""
abstract type AbstractJudgement{T} end

"""
Taxon is the supertype of all taxons.
"""
abstract type Taxon end

"""
NoTaxon is the supertype for when a Taxon cannot be coded (yet).

 - `NoTaxonEver` : A Taxon to show, that there is no SEM to code in this paper
 - `NoTaxonYet`:  A Taxon to show, that there is in fact a model to be coded, but this is at the current point not possible
          NoTaxonYet gives you the option to name the 'modeltype', you were not able to code, to spare your future self the work of going everything through.
          NoTaxonYet is also supposed to give your Record a timestamp 'accessdate' to further specify at what point there were no possibility to code the respective model.
"""
abstract type NoTaxon <: Taxon end

"""
AbstractPathmodel is the supertype of all pathmodels.
"""
abstract type AbstractPathmodel <: Taxon end
"""
AbstractCFA is the supertype of all CFAs.
"""
abstract type AbstractCFA <: Taxon end
abstract type AbstractLGCM <: Taxon end
abstract type AbstractCLPM <: Taxon end

