"""
    Model()

Use this function to group together multiple Judgements on the Model level. This means you have a Model/Taxon, and want to group together multiple 
    Judgements, like CFI, N ...

Return: Output value will be a dictionary containing ModelJudgements. 
"""

struct Model <: JudgementLevel
    judgements::Union{Dict{Symbol, Vector{AbstractJudgement}}, Missing}
end

function Model(j::AbstractJudgement...)
    check_judgement_level.(j, (ModelJudgement(), ))
    judgements = judgement_dict(j...)
    Model(judgements)
end


## Open
# JudgementLevel Hierarchy: Should Model be below Study be below Record?

## Ask Aaron: 
# 2 Options

# @newjudgement(
#    CFI,
#    ModelJudgement
#)


# 1) ModelDict within Taxon:
# Measurement(..., CFI()) ## Check if CFI was provided, if it is a mandatory argument.


## How to check if something we want to have coded was coded? 
