@testset "factor_variance" begin
    measurement = Measurement(n_variables=2, loadings=[1, 0.4], factor_variance=1.0)
    standalone_factor = StandaloneFactor(n_variables=2, loadings=[0.1, 0.2], factor_variance=0.5)

    @test rating(factor_variance(measurement)) == 1.0
    @test rating(factor_variance(standalone_factor)) == 0.5
end

@testset "extract studies" begin

    test_record_1 = Record(
        rater="NH",
        id="2a129694-550c-4396-be6f-00507b1dc7bb",
        Lang("en"),
        Study(
            N(100),
            Model(
                Standardized(true)
            )
        )
    )

    @test typeof(Study(test_record_1)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Study(test_record_1)) == 1
    @test rating(Study(judgements(test_record_1))[1], :N) == 100

    test_record_2 = Record(
        rater="NH",
        id="2a129694-550c-4396-be6f-00507b1dc7bb",
        Lang("en"),
        Study(
            N(100),
            Model(
                Standardized(true)
            )
        ),
        Study(
            N(200),
            Model(
                Standardized(false)
            )
        )
    )

    @test typeof(Study(test_record_2)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Study(test_record_2)) == 2


    test_record_0 = Record(
        rater="NH",
        id="2a129694-550c-4396-be6f-00507b1dc7bb",
        Lang("en")
    )

    @test typeof(Study(test_record_0)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Study(test_record_0)) == 0
    @test length(Study(judgements(test_record_0))) == 0

end


@testset "extract models" begin
    test_study_1 = Study(
        N(100),
        Model(
            Standardized(true)
        )
    )

    @test typeof(Model(test_study_1)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Model(test_study_1)) == 1

    test_study_2 = Study(
        N(100),
        Model(
            Standardized(true)
        ),
        Model(
            Standardized(false)
        )
    )


    @test typeof(Model(test_study_2)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Model(test_study_2)) == 2

    test_study_0 = Study(
        N(100)
    )

    @test typeof(Model(test_study_0)) == Vector{Union{JudgementLevel,AbstractJudgement}}
    @test length(Model(test_study_0)) == 0
end

@testset "get for JudgementLevel" begin
    @test get(Study(N(100)), :N)[1] == N(100)
    @test get(Study(N(100)), :Z) == []
end


@testset "extract Taxons" begin
    test_model = Model(Standardized(true),
        LatentPathmodel(
            Structural(structural_model=missing),
            Dict(
                :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
                :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
                :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
            )
        ),
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
    )

    @test typeof(Taxon(test_model)[1]) == LatentPathmodel
    @test length(Taxon(test_model)) == 2
end

@testset "extract measurement_model" begin
    

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



f = x -> get(Model(Study(x)), :Standardized)[1] == true

## Define for vectors
s = Study(test_record)

function Model(s::Vector{Union{JudgementLevel, AbstractJudgement}})
res_vec = []
for i in eachindex(s)
    push!(res_vec, Model(s[i]))
end

return res_vec
end

Model(s)

## Or

macro remove_model(expr)
    if isa(expr, Expr) && expr.head == :call && expr.args[1] == :Model
        return esc(expr.args[2])
    else
        return esc(expr)
    end
end

f = @remove_model x -> get(Model(Study(x)), :Standardized)[1] == true

for i in eachindex(s)
    Model(s[i]) = filter(f, Model(s[i]))
end



## so:
## 1) Extract the values without changing the function. This would require to 
## Define methods for Model and Study that can deal with vectors as input. Not quite sure
## How that would look. 
## Advantage: I could look at the resulting judgementLevel and use this as 
## function for updating the record Database at the correct position.

## How did I do this with rating? 
## I went through the vector outside of filter, and then just provided
## The input the function needed. This actually is similar to the second approach:


## 2) Use a macro to transform the function so it extracts values at Model[i], Study[i] ...
## 


## Problem: Within each study we also need to get a vector of models.
## How to allocate the correct models to the correct study? 







test_level = judgement_level(f(test_record))

typeof(test_level)

## Use this as function, maybe as macro?

## Name update_ModelJudgement if possible
j = 1

filtered = filter(f)

ModelJudgement(r::Record, j, filtered)
    Model(Study(r)[j]) = filtered
end


Model(Study(test_record)[1])[1] = N(100)



f(test_record) = Standardized(false)

## Take this and us it to automatically extract the vector where it should be saved.
## Maybe use a macro ?


## About indices: I can just go through with a loop and return vector. 


# Currently filter filters a vector of Studies or a Vector of Models and returns it 
# inside the record or study judgements field. 
end

