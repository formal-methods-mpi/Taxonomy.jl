"""
    Model()

Use this function to group together multiple Judgements and/or Taxons on the Model level. 

Return: Output value will be a dictionary containing ModelJudgements and/or Taxons. 
"""
struct Model <: JudgementLevel
    judgements::Union{Dict{Symbol,Vector{Union{AbstractJudgement,Taxon}}},Missing}
end

function Model(j::Union{AbstractJudgement,Taxon}...)

    check_judgement_level.(j, (ModelJudgement(),))

    judgements = judgement_dict(j...)
    Model(judgements)
end