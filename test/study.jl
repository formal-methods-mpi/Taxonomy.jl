@testset "Simple Study example provides the expected output" begin
    simple_study_test_judgements = judgements(
        Study(
            N(1000, 1),
            Empirical(true, 1),
            Measurement(n_variables=2, loadings=[0.53, 0.95], factor_variance=0.16)
        )
    )

    @test typeof(simple_study_test_judgements[:N][1]) == N{Int64}
    @test typeof(simple_study_test_judgements[:Empirical][1]) == Empirical{Bool}
    @test rating(simple_study_test_judgements[:Empirical][1]) == true
    @test simple_study_test_judgements[:Taxon][1] isa Measurement
end

@testset "Study() can not take Judgements of RecordLevel typpe" begin
    @test_throws ArgumentError Study(Lang("de", 1))
end
