"""
NoTaxonEver()

A Taxon to show, that there is no SEM to code in this paper.

```jldoctest
julia> NoTaxonEver()
NoTaxonEver

julia> NoTaxon()
NoTaxonEver

```
"""
struct NoTaxonEver <: NoTaxon end
NoTaxon() = NoTaxonEver()


"""
    NoTaxonYet(accessdate, modeltype = missing)

A Taxon to show, that there is in fact a model to be coded, but this is at the current point not possible.
NoTaxonYet requires a timestamp 'accessdate' to further specify at what point there were no possibility to code the respective model.
NoTaxonYet gives you the option to name the 'modeltype', you were not able to code, to spare your future self the work of going everything through.

julia> NoTaxonYet()

"""

struct NoTaxonYet <: Taxon
    accessdate::Date
    modeltype::Union{String, Missing}
    function NoTaxonYet(accessdate, modeltype = missing)
        @warn "This model is currently not possible to code? - please come back later."
        new(Date(accessdate), modeltype)
    end
end
NoTaxonYet(;accessdate, modeltype = missing) = NoTaxonYet(accessdate, modeltype)
