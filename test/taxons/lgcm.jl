mylgcm_sparse = LGCM(timecoding = [0,1,2,3,4])
mylgcm = LGCM(timecoding = [0,1,2,3,4], n_timepoints = 5, n_predictors = 0)
mylgcm_missing = LGCM(timecoding = J(missing))


@testset "LGCM" begin
    @test mylgcm.n_timepoints.rating == mylgcm_sparse.n_timepoints.rating == 5
    @test_throws MethodError LGCM(timecoding = "test")
    @test_throws MethodError LGCM(timecoding = 1)
    @test mylgcm_missing.n_timepoints == J(missing, 0.0, missing)
    @test_throws ArgumentError LGCM(timecoding = 1:4, n_timepoints = 3)
end


@testse "LGCM" begin
    test_lgcm_1 = Factor(n_variables = J(2), loadings = J([1, 0.4]), factor_variance = J(1))
    test_lgcm_2 = Factor(n_variables = 2, loadings = [1, 0.4], factor_variance = 1)

    @test test_factor_1.factor_variance.rating == test_factor_2.factor_variance.rating == 1
    @test test_factor_2.factor_variance == Judgement(1, 1.0, missing)

    @test_throws MethodError Factor(n_variables = "hi", loadings = [1, 0.4], factor_variance = 1)
end