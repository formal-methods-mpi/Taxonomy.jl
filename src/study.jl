"""
    Study()

Use this function to group together multiple Judgements and/or Taxons on the Study level. 

Return: Output value will be a dictionary containing StudyJudgements and/or Taxons. 
"""
struct Study <: JudgementLevel
    judgements::Union{Dict{Symbol,Vector{Union{AbstractJudgement, JudgementLevel}}},Missing}
end

function Study(j::Union{AbstractJudgement, JudgementLevel}...)

    check_judgement_level.(j, (StudyJudgement(),))

    judgements = judgement_dict(j...)
    Study(judgements)
end

