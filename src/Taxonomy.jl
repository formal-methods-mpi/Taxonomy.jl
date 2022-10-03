module Taxonomy
    export AbstractDOI, AbstractLocation
    include("abstracttypes.jl")

    import Dates
    import Dates: Date
    export Date
    export NoDOI, NoLocation
    include("metadata/location.jl")

    export DOI, UsualDOI, UnusualDOI
    include("metadata/doi.jl")
    
    import Base.convert, Base.==
    export J, Judgement, NoJudgement, convert, rating, location, certainty
    include("judgement.jl")

    export Record, taxons,  location, spec, data
    include("record.jl")

    import HTTP
    import JSON
    export MetaData, MinimalMeta, IncompleteMeta, ExtensiveMeta, url, year, author, journal, apa, json
    include("metadata/meta.jl")

    export NoTaxon
    include("taxons/taxon.jl")
    
    import StenoGraphs
    export Factor
    export CFA
    include("taxons/cfa.jl")
    export LGCM
    include("taxons/lgcm.jl")

    import UUIDs
    export generate_id
    include("uuid.jl")
end
