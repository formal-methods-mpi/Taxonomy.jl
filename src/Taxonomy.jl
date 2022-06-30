module Taxonomy
    import Dates

    include("abstracttypes.jl")
    import Dates: Date
    export Date
    export DOI, UsualDOI, UnusualDOI, NoDOI
    include("metadata/doi.jl")
    include("taxons/cfa.jl")
end



