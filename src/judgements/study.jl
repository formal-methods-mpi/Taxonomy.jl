"""
    Study()

Stores a dictionary with StudyJudgements.
"""

## This needs to get an abstract type? Same as Record, model

struct Study <: JudgementLevel
    judgements::Union{Dict{Symbol, Vector{AbstractJudgement}}, Missing}
end

function Study(j::AbstractJudgement...)
    check_judgement_level.(j, (StudyJudgement(), ))
    judgements = judgement_dict(j...)
    Study(judgements)
end


# Next action: 
## Add warning in judgement_dict if the same key appears twice

#function Study(j::AbstractJudgement...)
#    check_judgement_level.(j, (StudyJudgement(), ))
#    Study()
#end

judgement_level(x::Study) = StudyJudgement()
judgement_unique(x::Study) = true
judgement_key(x::Study) = :Study
