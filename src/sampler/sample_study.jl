## 1) Simple extractor that takes record and returns input field from the judgements. 
## Rename to get? for multiple dispatch?
extract_field = function(r::JudgementLevel, field::Symbol)
    if(field in keys(judgements(r)))
        return judgements(r)[field][1]
    else
       return nothing
    end
end

extract_field = function(r::Study, field::Symbol)
    if(field in keys(judgements(r)))
        return judgements(r)[field][1]
    else
       return Study()
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