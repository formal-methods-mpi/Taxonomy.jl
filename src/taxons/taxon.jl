"""
No taxons Taxon. 
- `NoTaxon` : A Taxon to show, that there is no pathmodel to code in this paper
- `NoTaxonYet`:  A Taxon to show, that there is in fact a model to be coded, but this is at the current point not possible
      NoTaxonYet gives you the option to name the 'modeltype', you were not able to code, to spare your future self the work of going everything through.

```jldoctest

# output

```
"""
struct NoTaxon <: Taxon end


struct NoTaxonYet <: Taxon
modeltype :: String
accessdate :: String
end

function NoTaxonYet(;modeltype,
    accessdate)
    NoTaxonYet(modeltype,accessdate)
end
