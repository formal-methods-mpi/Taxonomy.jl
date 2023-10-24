"""
    Study()

Use this function to group together multiple Judgements on the Study level. This means you have
    one Study, but want to group together the according Judgements like `N`, `Taxon`, etc.

Return: Output value will be a dictionary containing StudyJudgements. 
"""

struct Study <: JudgementLevel
    judgements::Union{Dict{Symbol, Vector{AbstractJudgement}}, Missing}
end

function Study(j::AbstractJudgement...)
    check_judgement_level.(j, (StudyJudgement(), ))
    judgements = judgement_dict(j...)
    Study(judgements)
end


