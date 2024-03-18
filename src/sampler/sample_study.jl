"""
    filter_judgements(db, field, comparison_func)

Filter records from a database based on a judgement field. 


# Arguments
"""
filter_judgements = function(r::RecordDatabase, field::Symbol, comparison_func)
    filter(record -> haskey(judgements(record.second), field) ? comparison_func(rating(judgements(record.second)[field][1])) : false, r)
end



## How to deal with multiple filter conditions?



extract_studies(r::Record)::Vector{Study} = r.judgements[:Study]

function extract_studies(r::RecordDatabase)::Vector{Study}
    study_vec = []
    for i in values(r)
        push!(study_vec, extract_studies(i)...) # what if i contains multiple studies? How to return Vector{Study}
    end
    return study_vec
end




## 1) Simple extractor that takes record and returns input field from the judgements. 
extract_field = function(r::Record, field::Symbol)
    if(field in keys(judgements(r)))
        judgements(r)[field]
    end
end


## 2) Extractor that goes over data base and extracts values. 
extract_values = function(r::RecordDatabase, field::Symbol)
    field_vec=[]
for i in values(r)
    if(field in keys(judgements(i)))
        push!(field_vec, extract_field(i, field)...) # what if i contains multiple studies? How to return Vector{Study}
    end
end
return field_vec
end


## 3) Go over database and return only those Records that are englisch

## Need to incorporate the judgementlevel I'm interested in, as AnyLevelJudgements are possible. 


## Argument for level and name, return a Vector of type Vector{AbstractJudgement}




## How to keep the allocation?


## Every study can have one Language, but each model can 