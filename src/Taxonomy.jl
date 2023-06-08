module Taxonomy
    export AbstractDOI, AbstractLocation
    export AbstractPathmodel, AbstractCFA, AbstractLGCM, AbstractCLPM
    export Measurement, Structural, LatentPathmodel, HierarchicalCFA, BifactorCFA, SimpleCLPM, SimpleLGCM
    export StandaloneFactor, ManifestPathmodel
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

    export Record, id, taxons,  location, spec, data
    include("record.jl")

    import HTTP
    import JSON
    export MetaData, MinimalMeta, IncompleteMeta, ExtensiveMeta, url, year, author, journal, apa, json
    include("metadata/meta.jl")

    export NoTaxon
    include("taxons/no_taxon.jl")
    
    import StenoGraphs
    export Measurement
    export Structural
    include("taxons/structural.jl")
    
    export Standalone_Factor
    include("taxons/measurement.jl")
    export SimpleLGCM
    export n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope,  covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope
    include("taxons/simple_lgcm.jl")

    import UUIDs
    export generate_id
    include("uuid.jl")

    export n_sample
    export factor_variance
    include("extractors.jl")

    export RecordDatabase
    import Base: UUID
    include("database.jl")

    include("pretty_printing.jl")

end
