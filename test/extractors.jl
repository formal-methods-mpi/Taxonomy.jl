using StenoGraphs
using Taxonomy
@testset "n_sample" begin
    lgcm = LGCM(n_sample = 100, n_timepoints = 2, timecoding = [0, 1], intercept = 1, slope = 1, variance_intercept = missing, variance_slope = missing)
    factor = Factor(n_sample = 100, n_variables = 2, loadings = [1, 0.4])
    cfa = CFA(n_sample = 100, measurement_model = [Factor(n_variables = 2, loadings = [1, 0.4]), Factor(n_variables = 2, loadings = [0.7, 0.3])],
    structural_model = @StenoGraph fac1 → fac2)

    @test rating.(n_sample.([lgcm, factor, cfa])) == [100, 100, 100]
    @test ismissing(rating(n_sample(LGCM(n_timepoints = 2, timecoding = [1,2], intercept = 1, slope = 1, variance_intercept = 0.5, variance_slope = 0.5))))
end
