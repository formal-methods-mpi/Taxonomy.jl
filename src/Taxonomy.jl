module Taxonomy
    export AbstractDOI, AbstractLocation
    include("abstracttypes.jl")

    import Dates
    import Dates: Date
    export Date
    export DOI, UsualDOI, UnusualDOI, NoDOI, url
    include("metadata/doi.jl")
    
    import HTTP
    import JSON
    export MetaData, MinimalMeta, IncompleteMeta, ExtensiveMeta, year, author, journal, apa, json
    include("metadata/meta.jl")

    import Base.convert
    export J, Judgement, convert
    include("judgement.jl")

    export Record
    include("record.jl")

    export GFactor
    include("taxons/cfa.jl")
end



