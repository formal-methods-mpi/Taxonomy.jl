# @testset "factor_variance" begin
#     measurement = Measurement(n_variables=2, loadings=[1, 0.4], factor_variance=1.0)
#     standalone_factor = StandaloneFactor(n_variables=2, loadings=[0.1, 0.2], factor_variance=0.5)

#     @test rating(factor_variance(measurement)) == 1.0
#     @test rating(factor_variance(standalone_factor)) == 0.5
# end

# @testset "extract studies" begin

#     test_record_1 = Record(
#         rater="NH",
#         id="2a129694-550c-4396-be6f-00507b1dc7bb",
#         Lang("en"),
#         Study(
#             N(100),
#             Model(
#                 Standardized(true)
#             )
#         )
#     )

#     @test typeof(Study(test_record_1)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Study(test_record_1)) == 1
#     @test rating(Study(judgements(test_record_1))[1], :N) == 100

#     test_record_2 = Record(
#         rater="NH",
#         id="2a129694-550c-4396-be6f-00507b1dc7bb",
#         Lang("en"),
#         Study(
#             N(100),
#             Model(
#                 Standardized(true)
#             )
#         ),
#         Study(
#             N(200),
#             Model(
#                 Standardized(false)
#             )
#         )
#     )

#     @test typeof(Study(test_record_2)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Study(test_record_2)) == 2


#     test_record_0 = Record(
#         rater="NH",
#         id="2a129694-550c-4396-be6f-00507b1dc7bb",
#         Lang("en")
#     )

#     @test typeof(Study(test_record_0)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Study(test_record_0)) == 0
#     @test length(Study(judgements(test_record_0))) == 0

# end


# @testset "extract models" begin
#     test_study_1 = Study(
#         N(100),
#         Model(
#             Standardized(true)
#         )
#     )

#     @test typeof(Model(test_study_1)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Model(test_study_1)) == 1

#     test_study_2 = Study(
#         N(100),
#         Model(
#             Standardized(true)
#         ),
#         Model(
#             Standardized(false)
#         )
#     )


#     @test typeof(Model(test_study_2)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Model(test_study_2)) == 2

#     test_study_0 = Study(
#         N(100)
#     )

#     @test typeof(Model(test_study_0)) == Vector{Union{JudgementLevel,AbstractJudgement}}
#     @test length(Model(test_study_0)) == 0
# end

# @testset "get for JudgementLevel" begin
#     @test get(Study(N(100)), :N)[1] == N(100)
#     @test get(Study(N(100)), :Z) == []
# end


#@testset "extract Taxons" begin
#     test_model = Model(Standardized(true),
#         LatentPathmodel(
#             Structural(structural_model=missing),
#             Dict(
#                 :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
#                 :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
#                 :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
#                 :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
#                 :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
#             )
#         ),
#         LatentPathmodel(
#             Structural(structural_model=missing),
#             Dict(
#                 :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
#                 :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
#                 :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
#                 :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
#                 :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
#             )
#         )
#     )

#     @test typeof(Taxon(test_model)[1]) == LatentPathmodel
#     @test length(Taxon(test_model)) == 2
# end

#@testset "extract measurement_model" begin
  
    using Taxonomy
    using Taxonomy.Judgements

    db = RecordDatabase()

    test_record = Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true), 
            LatentPathmodel(
                Structural(structural_model = missing ),
                Dict(
                    :IP => Measurement(n_variables = 3, factor_variance = missing, loadings = missing, quest_scale = 7),
                    :IN => Measurement(n_variables = 4, factor_variance = missing, loadings = missing, quest_scale = 6),
                    :DN => Measurement(n_variables = 3, factor_variance = missing, loadings = missing, quest_scale = 7),
                    :BC => Measurement(n_variables = 3, factor_variance = missing, loadings = missing, quest_scale = 5),
                    :IB => Measurement(n_variables = 5, factor_variance = missing, loadings = missing, quest_scale = 5)
                )
            )),
            Model(Standardized(false))
        ), 
        Study(N(120))
    )

    db += test_record





## 1) Go through all Records of a Database.
## 2) Depending on the JudgementLevel, either loop over Studies or Models. This is done automatically by the filter function. So what I need to figure out is
## how to provide the filter function with the correct JudgementLevel - Vector.
## Two option of defining Study in the filter-function:

####################################################################
## Option A 
####################################################################
#Within the function.

## 1) Ok, so now I have to loop over the single records. 
## 2) Then I have to extract the Study-Vector from each record. Not a Problem!
## 3) Now I have a Vector of Studys. Here get fails, because it only makes sense for one dict!
## 4) I could try to make it work with a vector of Boolean values: It has the same length as Study-Vector and selects only those Studies that the condition 
##    is met for:

## Define return types::!
# Base.get(x::Vector{Union{T,AbstractJudgement}} where T <: JudgementLevel, key::Symbol) = [get(x[i], key) for i in eachindex(x)]
# function Taxonomy.rating(x::Vector{Vector{Union{JudgementLevel,AbstractJudgement}}}) 
#     res_vec = []
#     for i in eachindex(x) ## Deal with different cases here!
#         push!(res_vec, rating(x[i][1]))
#     end
    
#     return res_vec
# end

# function Base.filter(f, r::RecordDatabase)

#     for i in keys(r)

#         judgements(r[i])[:Study] = Study(r[i])[f(r[i])]

#     end

#     return r
# end

# ## Go through all levels and try the function, use the results if it works and dont if it doesnt. Maybe return a default value if the field is not found?


# filter(x -> rating(get(Study(x), :N)) .== 100, db)

# Study(db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])


# ## Here the problem arises that I have to loop over the study vec first to extract the models for each study.  
# filter(x -> rating(get(Model(Study(x), :Standardized)) .== true, db))
# Study(db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])

## tryout --------:




####################################################################
## Option B:
####################################################################
## Define JudgementLevel in the second argument!



## Doesnt make sense because this would mean we don't provide the full database, but only the STudies ...
## But what if we loop over the database, try Study(), Model() etc. for the second argument and see if f() returns something sensible?

function Base.filter(f, s::Vector{Union{T,AbstractJudgement}} where T <: JudgementLevel)
    res_vec = eltype(s)[]
for i in eachindex(s)
    if f(s[i])
        res_vec = push!(res_vec, s[i])
    end
end

return res_vec
end




function Base.filter(f, r::RecordDatabase)

    for i in keys(r)

       judgements(r[i])[:Study] = filter(f, Study(r[i]))

        for j in eachindex(Study(r[i]))

            filtered_model = filter(f, Model(Study(r[i])[j]))
           judgements(judgements(r[i])[:Study][j])[:Model] = length(filtered_model) > 0 ? filtered_model : Model(Study(r[i])[j])

        end
        
    end

    return r
end

filter(z -> rating(get(z, :N)) == 100, db)
Study(db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])

## Yaaay, this actually worked. Clean up now and try with edge cases and TAxons. 

# filter(z -> rating(get(z, :Lang)) == "en", test_record)
# filter(z -> rating(get(z, :N)) == 100, Study(test_record))
# filter(z -> rating(get(z, :Standardized)) == true, Model(Study(test_record)[1]))





