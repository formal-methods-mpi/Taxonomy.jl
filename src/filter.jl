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

function Base.filter(f, db::RecordDatabase, level::AbstractString)::RecordDatabase

    @assert level in ["Record", "Study", "Model", "Taxon"] "Invalid level. Choose from 'Record', 'Study', 'Model', 'Taxon'"

    if level == "Record"
        db = filter(f, db)
    else

        for current_record in keys(db)
            studies = Study(db[current_record])

            if level == "Study"
                filtered_study = filter(f, studies)
                if length(filtered_study) > 0
                    judgements(db[current_record])[:Study] = filtered_study
                else
                    delete!(judgements(db[current_record]), :Study)
                end
            else

                for current_study in eachindex(studies)
                    models = Model(studies[current_study])
                    if level == "Model"
                        filtered_model = filter(f, models)
                        if length(filtered_model) > 0
                            judgements(Study(db[current_record])[current_study])[:Model] = filtered_model
                        else
                            delete!(judgements(judgements(db[current_record])[:Study][current_study]), :Model)
                        end
                    else
                        for current_model in eachindex(models)
                            taxons = Taxon(models[current_model])
                            if level == "Taxon"
                                filtered_taxons = filter(f, taxons)

                                if length(filtered_taxons) > 0
                                    judgements(Model(Study(db[current_record])[current_study])[current_model])[:Taxon] = filtered_taxons
                                else
                                    delete!(judgements(Model(Study(db[current_record])[current_study])[current_model]), :Taxon)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return db

end



#                judgements(judgements(r[i])[:Study][j])[:Model] = length(filtered_model) > 0 ? filtered_model : Model(Study(r[i])[j])
