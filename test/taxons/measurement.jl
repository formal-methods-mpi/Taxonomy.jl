@testset "Measurement" begin
    test_factor_1 = Measurement(n_variables = J(2), loadings = J([1, 0.4]), factor_variance = J(1))
    test_factor_2 = Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 1)

    @test rating(factor_variance(test_factor_1)) == rating(factor_variance(test_factor_2)) == 1
    @test factor_variance(test_factor_2) == Judgement(1, 1.0, missing)
    
    @test_throws MethodError Measurement(n_variables = "hi", loadings = [1, 0.4], factor_variance = 1)
end
