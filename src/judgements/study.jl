"""
    Study()

Stores a dictionary with StudyJudgements.
"""
struct Study <: AbstractJudgement{Dict} end

#function Study(j::AbstractJudgement...)
#    check_judgement_level.(j, (StudyJudgement(), ))
#    Study()
#end

function Study(x...)
    @warn("`Study()` is just a mock and doesnt store anything.")
    Study()
end

judgement_level(x::Study) = RecordJudgement()
judgement_unique(x::Study) = true
judgement_key(x::Study) = :Study
