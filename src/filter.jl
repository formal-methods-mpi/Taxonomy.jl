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


"""
    filter(f, db::RecordDatabase, level::AbstractString)::RecordDatabase

Filter the database at a given nesting level. 

# Arguments
- `f`: A function returning a boolean value for filtering a dict at the specified level. 
- `db`: A RecordDatabase object.
- `level`: The character string of the level at which to filter the database. Possible values are `"Record"`, `"Study"`, `"Model"`, `"Taxon"`.

# Examples
```jldoctest filter-examples

## Example just for demonstration, coding is not actually derived from the paper!

using Taxonomy
using Taxonomy.Judgements

test_db = RecordDatabase()

test_db += Record(
    rater="NH",
    id="2a129694-550c-4396-be6f-00507b1dc7ba",
    location=DOI("10.1007/s10869-019-09648-5"),
    Lang("en"),
    Study(
        N(100, 0.8),
        Model(Standardized(false),
            LatentPathmodel(
                Structural(structural_model=missing),
                Dict(
                    :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                    :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
                    :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                    :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
                    :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
                )
            )
        ),
        Model(Standardized(true),
            NoTaxon()
        )
    ),
    Study(
        N(200, 0.98),
        Model(Standardized(false),
        ),
        Model(Standardized(false))
    )
)

## Filtering on Taxon level
filter_Pathmodel = filter(x -> typeof(x) == NoTaxonEver, test_db, "Taxon")
Model(Study(filter_Pathmodel[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[2]

# output
Model(Dict{Symbol, Vector{Union{Taxon, AbstractJudgement}}}(:Taxon => [NoTaxonEver
], :Standardized => [Standardized{Bool}(true, 1.0, missing)]))
```

```jldoctest filter-examples

## Filtering on Model level
filter_Standardized = filter(x -> rating(x, :Standardized) == true, test_db, "Model")
Model(Study(filter_Standardized[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])

# output
1-element Vector{Union{Model, AbstractJudgement}}:
 Model(Dict{Symbol, Vector{Union{Taxon, AbstractJudgement}}}(:Taxon => [NoTaxonEver
], :Standardized => [Standardized{Bool}(true, 1.0, missing)]))

```

```jldoctest filter-examples

## Filtering on Study level
filter_N = filter(x -> certainty(x, :N) > 0.9, test_db, "Study")
Study(filter_N[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])


# output
1-element Vector{Union{Study, AbstractJudgement}}:
 Study(Dict{Symbol, Vector{Union{JudgementLevel, AbstractJudgement}}}(:N => [N{Int64}(200, 0.98, missing)]))
```
"""
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