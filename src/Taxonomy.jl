module Taxonomy
    export AbstractDOI, AbstractLocation
    export AbstractJudgement
    export Taxon, JudgementLevel
    export AbstractPathmodel, AbstractCFA, AbstractLGCM, AbstractCLPM
    export Structural, LatentPathmodel, HierarchicalCFA, BifactorCFA, SimpleCLPM, SimpleLGCM
    export StandaloneFactor, ManifestPathmodel
    include("abstracttypes.jl")

    import Preferences: @set_preferences!, @load_preference
    import Dates
    import Dates: Date
    export Date
    export NoDOI, NoLocation
    export auto_request_meta
    include("metadata/location.jl")

    export DOI, UsualDOI, UnusualDOI
    include("metadata/doi.jl")
    
    import Base.convert, Base.==
    export Judgements, J, Judgement, NoJudgement, convert, rating, comment, certainty
    export JudgementNumber, JudgementBool, JudgementInt, JudgementString
    export JudgementVecNumber, JudgementVecBool, JudgementVecInt, JudgementVecString
    include("judgements/Judgements.jl")

    using Taxonomy.Judgements

    export Study
    include("study.jl")

    export Record, id, judgements,  location, spec, data, ExtractStudy
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
    
    export Standalone_Factor, Measurement, Fixed, strip_fixed
    include("taxons/measurement.jl")

    export SimpleLGCM
    export n_timepoints, timecoding, intercept, slope, nonlinear_timecoding, variance_intercept, variance_slope,  covariance_intercept_slope, variances_timepoints, n_predictors, predictor_paths_intercept, predictor_paths_slope
    include("taxons/simple_lgcm.jl")

    include("taxons/latent_pathmodel.jl")

    import UUIDs
    export generate_id
    include("uuid.jl")

    export RecordDatabase, check_uuid, check_url
    import Base: UUID
    include("database.jl")

    export factor_variance, structural_model, doi
    include("extractors.jl")

    include("pretty_printing.jl")

    export Model
    include("model.jl")

    include("deprecated.jl")

    export extract_field, extract_values, filter_judgements
    include("sampler/sample_study.jl")
end
