@testset "Simple Study example provides the expected output" begin
    simple_study_test_judgements = judgements(
        Study(
            N(1000, 1),
            Empirical(true, 1),
            Model(Measurement(n_variables=2, loadings=[0.53, 0.14], factor_variance=0.16), 
              CFI(0.95, 1)
              )
        )
    )

    @test typeof(simple_study_test_judgements[:N][1]) == N{Int64}
    @test typeof(simple_study_test_judgements[:Empirical][1]) == Empirical{Bool}
    @test rating(simple_study_test_judgements[:Empirical][1]) == true
    @test simple_study_test_judgements[:Model][1] isa Model
end

@testset "Study() can not take Judgements of RecordLevel typpe" begin
    @test_throws ArgumentError Study(Lang("de", 1))
end
