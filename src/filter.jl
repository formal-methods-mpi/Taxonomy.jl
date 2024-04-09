# function Base.filter(f, s::Vector{Union{JudgementLevel,AbstractJudgement}})::Vector{Union{JudgementLevel,AbstractJudgement}}
#     res_vec = []
#     for i in eachindex(s)
#         if f(s[i])
#             res_vec = push!(res_vec, s[i])
#         end
#     end

#     return res_vec
# end

function Base.filter(f, s::Vector{Union{T,AbstractJudgement}} where {T<:JudgementLevel})
    res_vec = eltype(s)[]
    for i in eachindex(s)
        if f(s[i])
            res_vec = push!(res_vec, s[i])
        end
    end

    return res_vec
end

Base.filter(f, s::JudgementLevel)::Vector{Union{JudgementLevel,AbstractJudgement}} = f(s) ? [s] : []

struct filter_levels 
end



function Base.filter(f, db::RecordDatabase, level::AbstractString)::RecordDatabase

    @assert level in ["Record", "Study", "Model", "Taxon"] "Invalid level. Choose from 'Record', 'Study', 'Model', 'Taxon'"

    if typeof(level) == "Record"
        db = filter(f, db)
    end

    for current_record in keys(db)

        studies = Study(db[current_record])


        if typeof(level) == "Study"
            judgements(db[current_record])[:Study] = filter(f, studies)

        else

            for current_study in eachindex(studies)
                models = Model(studies[current_study])
                if typeof(level) == "Model"
                    judgements(judgements(db[current_record])[:Study][current_study])[:Model] = filter(f, models)

                else
                    for current_model in eachindex(models)
                        taxons = Taxon(models[current_model])
                        if typeof(level) == "Taxon"
                            judgements(Models(Study(db[current_record])[current_study])[current_model])[:Taxon] = filter(f, taxons)
                        end
                    end
                end
            end

        end
    end
    return db

end



#                judgements(judgements(r[i])[:Study][j])[:Model] = length(filtered_model) > 0 ? filtered_model : Model(Study(r[i])[j])
