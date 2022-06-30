module Taxonomy
    include("abstracttypes.jl")
    export DOI, UsualDOI, UnusualDOI
    include("metadata/doi.jl")
    include("taxons/cfa.jl")
end



