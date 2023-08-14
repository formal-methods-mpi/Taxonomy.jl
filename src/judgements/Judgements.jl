module Judgements
    import Taxonomy: AbstractJudgement
    check_certainty(c) = ((c < 0.0) || (c > 1.0)) ? throw(ArgumentError("Certainty must be between 0 and 1.")) : nothing
    export JudgementLevel, AnyLevelJudgement, RecordJudgement, StudyJudgement
    include("level.jl")
    export @newjudgement
    export J, Judgement, NoJudgement, convert, rating, comment, certainty
    include("judgement.jl")
    # exports via code gen within the file
    include("constrained.jl")
    export JudgementLanguage
    include("language.jl")
end