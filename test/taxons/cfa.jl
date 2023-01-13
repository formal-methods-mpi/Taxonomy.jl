@testset "Factor" begin
    test_factor_1 = Factor(n_observed = J(2), loadings = J([1, 0.4]), factor_variance = J(1))
    test_factor_2 = Factor(2, [1, 0.4], 1, 0, 0, 0, 0)

    @test test_factor_1.factor_variance.rating == test_factor_2.factor_variance.rating == 1
    @test test_factor_2.factor_variance == Judgement(1, 1.0, missing)
    
    @test_throws MethodError Factor(n_observed = "hi", loadings = [1, 0.4], factor_variance = 1)
end
