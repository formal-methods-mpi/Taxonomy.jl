@testset "Measurement" begin
    test_factor_1 = Measurement(
        n_variables=J(2),
        loadings=J([1, 0.4]),
        factor_variance=J(1)
    )

    @test rating(factor_variance(test_factor_1)) == 1
    @test_throws TypeError Measurement(n_variables="hi", loadings=[1, 0.4], factor_variance=1)
end

@testset "Measurement can take ModelJudgements" begin
    test_factor_1 = Measurement(
        CFI(0.95, 1),
        n_variables=J(2),
        loadings=J([1, 0.4]),
        factor_variance=J(1)
    )

rating(judgements(test_factor_1)[:CFI][1]) == 0.95

end

@testset "Can't put the wrong JudgementType into a Taxon" begin

@test_throws ArgumentError Measurement(
    n_variables=2,
    loadings=[1, 0.4],
    factor_variance=1, 
    N(100, 1) # This is actually a StudyJudgement
)
end
