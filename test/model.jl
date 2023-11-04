@testset "A Modeljudgement can be added to a Measurement" begin
    @test judgements(
        Model(Measurement(n_variables=2, loadings=[0.53, 0.14], factor_variance=0.16), 
              CFI(0.95, 1)
              )
    )[:CFI][1] == CFI(0.95, 1)
end

@testset "Taxon can't take a RecordJudgement" begin
    @test_throws ArgumentError(Model(Measurement(n_variables=2, loadings = [0.1, 0.1], factor_variance=0.16)), Lang(100, 1))
end