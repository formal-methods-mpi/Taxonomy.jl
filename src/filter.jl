function Base.filter(f, s::Vector{Union{JudgementLevel,AbstractJudgement}})::Vector{Union{JudgementLevel,AbstractJudgement}}
    res_vec = []
    for i in 1:length(s)
        if f(s[i])
            res_vec = push!(res_vec, s[i])
        end
    end

    return res_vec
end

Base.filter(f, s::JudgementLevel)::Vector{Union{JudgementLevel, AbstractJudgement}} = f(s) ? [s] : []


function Base.filter(f, db::RecordDatabase, level::JudgementLevel)::RecordDatabase

    if typeof(level) == Record       
        db = filter(f, db)
    end

    for record in keys(db)

        record_studies = Study(db[record])

     
        if typeof(level) == Study
        judgements(db[record])[:Study] = filter(f, record_studies)
        end

        if typeof(level) == Model
            for j in eachindex(record_studies)
                judgements(judgements(db[record])[:Study][j])[:Model] = filter(f, Model(record_studies[j]))
            end
        end

    end
return db

end