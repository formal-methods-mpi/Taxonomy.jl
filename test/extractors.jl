@testset "factor_variance" begin
    measurement = Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    standalone_factor = StandaloneFactor(n_variables = 2, loadings = [0.1, 0.2], factor_variance = 0.5)

    @test rating(factor_variance(measurement)) == 1.0
    @test rating(factor_variance(standalone_factor)) == 0.5
end