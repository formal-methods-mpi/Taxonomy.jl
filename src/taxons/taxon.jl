#A Taxon to show, that there is no pathmodel to code in this paper
struct NoTaxon <: Taxon end

#A Taxon to show, that there is in fact a model to be coded, but this is at the current point not possible
struct NoTaxonYet <: Taxon end
function Record(; rater = missing, id = missing, location = missing, meta = missing, taxons = NoTaxonYet, spec = missing, data = missing)
    if taxons = NoTaxonYet
        @warn "This model is currently not possible to code? - please come back later."
    end
