# Do cleanup and tests on a different branch using this file as template. 


using Test
using Taxonomy
using Taxonomy.Judgements


@newjudgement(
    Lang2,
    RecordJudgement, # Specify on which level this judgement should be used. Study level in this case.  
    """
    The number of observations in the study. Takes integer values or missings. 
    """,
    Int # Input type. In this case Integer. 
)

@newjudgement(
    Empirical,
    ModelJudgement, # Specify on which level this judgement should be used. Study level in this case.  
    """
    The number of observations in the study. Takes integer values or missings. 
    """,
    Bool # Input type. In this case Integer. 
)



# Example Record db
db = RecordDatabase()

db += Record(
    rater="VK",
    id="7548949d-b2f5-436f-8577-4237fb51d5a7",
    location=DOI("10.1007/s10869-019-09648-5"),
    Lang("de"),
    Lang2(12),
    Study(
        N(100)
    )
)

db += Record(
    rater="VK",
    id="2a129694-550c-4396-be6f-00507b1dc7ba",
    Lang("en"),
    Lang2(6),
    Study(
        N(100)
    ),
    Study(
        N(200)
    )
)

db += Record(
    rater="VK",
    id="2a129694-550c-4396-be6f-00507b1dc7bb",
    Lang("en"),
    Lang2(10),
    Study(
        N(100),
        Model(Empirical(true)),
        Model(Empirical(false)
        )),
    Study(
        N(200),
        Model(Empirical(true)),
        Model(Empirical(true))
    ))

db += Record(
    rater="VK",
    id="2a129694-550c-4396-be6f-00507b1dc7bc",
    Lang2(10),
    Study(
        N(100)
    ),
    Study(
        N(200)
    )
)

my_db = deepcopy(db)


#################
## Trying multiple filter conditions


# Taxonomy.rating(x::Record, field::Symbol) = rating(extract_field(x, field))
Taxonomy.rating(x::Pair{Base.UUID,Record}, field::Symbol) = rating(x.second, field)
Taxonomy.rating(x::JudgementLevel, field::Symbol) = rating(extract_field(x, field))

## Need the same for Judgements, so I can filter all Judgements > 90 e.g.


## Currently enough to filter like I need it righ now: (commented out because overwritten way down)
#filter(record -> rating(record, :Lang) == "en" || rating(record, :Lang2) == 10, db)




#################################
# Implement custom filter methods for our Judgements
#################################
## Filter applies a function to each element of a collection and returns a new collection containing only the elements for which the function returns true.
## The same for a Model collection. Judgements of a Study are a Dict, with one field called Model. 
## This Model field contains a Vector{Union{JudgementLevel, AbstractJudgement}} containing different Models

## filter method for Studys
my_record = Record(
    rater="VK",
    id="2a129694-550c-4396-be6f-00507b1dc7bb",
    Lang("en"),
    Lang2(10),
    Study(
        N(100),
        Model(
            Empirical(true)
        )
    ),
    Study(
        N(200),
        Model(
            Empirical(false)
        )
    )
)

my_study = Study(
    N(100),
    Model(
        Empirical(true)
    ),
    Model(
        Empirical(false)
    )
)


## Extract judgement level vectors ------------------
function extract_studies(r::Record)::Vector{Union{JudgementLevel,AbstractJudgement}}
    if :Study in keys(judgements(r))
        return judgements(r)[:Study]
    else
        return nothing
    end
end

extract_studies(my_record)

function extract_models(s::Study)::Vector{Union{JudgementLevel,AbstractJudgement}}
    if :Model in keys(judgements(s))
        return judgements(s)[:Model]
    else
        return nothing
    end
end

## filtering on Model level from database input
judgements(judgements(db[Taxonomy.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[:Study][1])[:Model] = filter(study -> rating(study, :N) == 100, judgements(my_record)[:Study])
## Return Filtered models and update Study for all elements in the vector
## Write extractors for getting study and model from RecordDB, record, StudyVec


## Do the same like below for study and database, but this time the study vector is the input, and it gets updated according to  model filters. 
check_key(d::RecordDatabase, k::Base.UUID) = k in keys(d)
check_key(d::Dict, k::Symbol) = k in keys(d)



## Define filters ---------------------------------------

function Base.filter(f, s::Vector{Union{JudgementLevel,AbstractJudgement}})::Vector{Union{JudgementLevel,AbstractJudgement}}
    res_vec = []
    for i in 1:length(s)
        if f(s[i])
            res_vec = push!(res_vec, s[i])
        end
    end

    return res_vec
end

Base.filter(f, s::JudgementLevel)::Vector{Union{JudgementLevel,AbstractJudgement}} = f(s) ? [s] : []


## Test filters -----------------------
models = extract_models(my_study)
filter(x -> rating(x, :N) != 100, extract_field(my_record, :Study))
filter(x -> rating(x, :Empirical) == true, models)

studys = judgements(my_record)[:Study]

filter(x -> rating(x, :N) == 200, studys)



function Base.filter(f, db::RecordDatabase)#::RecordDatabase 

    for record in keys(db)

        #Study level
        #judgements(db[record])[:Study] = filter(f, judgements(db[record])[:Study])

        record_studies = extract_studies(db[record])

        ## Check if there are studies in this record
        if record_studies != nothing

            # Model level
            for study in eachindex(record_studies)
                current_study = record_studies[study]

                ## Filter models if there are models in this study

                ## This has to return the models, if the key we are searching for in f is not in the model. 
                if check_key(judgements(current_study), :Model)
                    judgements(judgements(db[record])[:Study][study])[:Model] = filter(f, extract_models(current_study))
                end

            end

            # Study level
            judgements(db[record])[:Study] = filter(f, record_studies)


        end

    end

    return db
end

## How to deal with stuff we don't want to keep?
# Go through each judgement level and check if there is the field-name somewhere. If yes, 
## So for each study extract the model keys, check if the field is in there. Also check if the field name is in the study keys. If it is in either, filter both and keep 
## all that get returned. It gets complicated though in case the same field name is specified multiple times: should it only be returned if all are true, or is it enough 
## if it is true on one level?

Base.filter(f, nothing) = return nothing


record = Taxonomy.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")
study = 1

## Here it should return only one study, because  one study has a model with Empirical == true
db = filter(study -> rating(study, :Empirical) == false, db)

judgements(db[Taxonomy.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[:Study]

f = study -> rating(study, :N) == 200


## How to filter Taxons?
## How to deal with with different levels in &/| filters?






## Combine both:
## For now suppose each Judgement can only be on one level
## Filter all Studys with N = 100

## This works for the RecordLevel. 
# filter(record -> rating(record, :Lang) == "en" || rating(record, :Lang2) == 10, db)

## However, I want to be able to specify any level:
# filter(x -> rating(x, :N) == 100, db)

## This might get a bit tricky if e.g. :N can be on multiple levels. 
## Maybe additional arguement to specify the levels I want to search in, default ist all



## Use filter on the db, but with a specific function that filters on deeper levels.
## This function returns true if a record should be kept. 

## record is the individual key value pair. 
## rating returns the field for this key value pair. This can by Study. 
## So now I've got the study field. 

## Filtering on Study level from database input
# function Base.filter(f, db::RecordDatabase)::RecordDatabase 
#     for i in keys(db)
#     judgements(db[i])[:Study] = filter(f, judgements(db[i])[:Study])
#     end
#     return db
# end

# db = filter(study -> rating(study, :N) == 200, db)
# judgements(db[Taxonomy.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[:Study]
