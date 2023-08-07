module Taxonomy
    export AbstractDOI, AbstractLocation
    export AbstractJudgement
    export AbstractPathmodel, AbstractCFA, AbstractLGCM, AbstractCLPM
    export Structural, LatentPathmodel, HierarchicalCFA, BifactorCFA, SimpleCLPM, SimpleLGCM
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
    export Judgements, J, Judgement, NoJudgement, convert, rating, location, certainty
    include("judgements/Judgements.jl")
    import Taxonomy.Judgements: J, Judgement, NoJudgement, rating, location, certainty

    export Record, id, judgements,  location, spec, data
    include("record.jl")

    import HTTP
    import JSON
    export MetaData, MinimalMeta, IncompleteMeta, ExtensiveMeta, url, year, author, journal, apa, json
    include("metadata/meta.jl")

    export NoTaxon, NoTaxonEver, NoTaxonYet
    include("taxons/no_taxon.jl")
    
    import StenoGraphs
    export Structural
    include("taxons/structural.jl")
    
    export Standalone_Factor, Measurement
    include("taxons/measurement.jl")

    export SimpleLGCM
    export n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope,  covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope
    include("taxons/simple_lgcm.jl")

    include("taxons/latent_pathmodel.jl")

    import UUIDs
    export generate_id
    include("uuid.jl")

    export n_sample, factor_variance, structural_model
    include("extractors.jl")

    export RecordDatabase
    import Base: UUID
    include("database.jl")

    include("pretty_printing.jl")

end
