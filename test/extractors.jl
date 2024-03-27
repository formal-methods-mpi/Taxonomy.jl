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
