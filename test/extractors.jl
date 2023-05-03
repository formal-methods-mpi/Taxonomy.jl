@testset "n_sample" begin
    lgcm = LGCM(n_sample = 100, n_timepoints = 2, timecoding = [0, 1])
    factor = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    cfa = CFA(n_sample = 100, measurement_model = [Factor(n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0), Factor(n_variables = 2, loadings = [0.7, 0.3], factor_variance = 1.0)],
    structural_model = @StenoGraph fac1 → fac2)

    @test rating.(n_sample.([lgcm, factor, cfa])) == [100, 100, 100]
    @test ismissing(rating(n_sample(LGCM(n_timepoints = 2, timecoding = [1,2]))))
end


@testset "factor_variance" begin
    factor = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    standalone_factor = Standalone_Factor(n_sample = 100, n_variables = 2, loadings = [0.1, 0.2], factor_variance = 0.5)

    @test rating(factor_variance(factor)) == 1.0
    @test rating(factor_variance(standalone_factor)) == 0.5
end