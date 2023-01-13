using StenoGraphs
@testset "n_sample" begin
    lgcm = LGCM(n_sample = 100)
    factor = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0)
    cfa = CFA(n_sample = 100, measurement_model = [Factor(n_variables = 2, loadings = [1, 0.4], factor_variance = 1.0), Factor(n_variables = 2, loadings = [0.7, 0.3], factor_variance = 1.0)],
    structural_model = @StenoGraph fac1 → fac2)

    @test rating.(n_sample.([lgcm, factor, cfa])) == [100, 100, 100]
    @test ismissing(rating(n_sample(LGCM())))
end
