module Taxonomy
    export AbstractDOI, AbstractLocation
    include("abstracttypes.jl")

    import Dates
    import Dates: Date
    export Date
    export DOI, UsualDOI, UnusualDOI, NoDOI, url
    include("metadata/doi.jl")
    
    import Base.convert
    export J, Judgement, convert
    include("judgement.jl")

    export Record, taxons,  location, spec, data
    include("record.jl")

    import HTTP
    import JSON
    export MetaData, MinimalMeta, IncompleteMeta, ExtensiveMeta, year, author, journal, apa, json
    include("metadata/meta.jl")

    export GFactor
    include("taxons/cfa.jl")
end



