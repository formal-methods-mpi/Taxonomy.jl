@testset "n_sample" begin
    simple_lgcm = SimpleLGCM(n_sample = 100, n_timepoints = 2, timecoding = [0, 1])
    measurement = Measurement(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    structural = Structural(n_sample = 100, structural_graph = @StenoGraph fac1 → fac2)

    @test rating.(n_sample.([simple_lgcm, measurement, structural])) == [100, 100, 100]
    @test ismissing(rating(n_sample(SimpleLGCM(n_timepoints = 2, timecoding = [1,2]))))
end


@testset "factor_variance" begin
    measurement = Measurement(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    standalone_factor = StandaloneFactor(n_sample = 100, n_variables = 2, loadings = [0.1, 0.2], factor_variance = 0.5)

    @test rating(factor_variance(measurement)) == 1.0
    @test rating(factor_variance(standalone_factor)) == 0.5
end