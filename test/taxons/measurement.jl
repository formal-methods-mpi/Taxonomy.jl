@testset "Most basic Measurement" begin
    test_factor_1 = Measurement(
        n_variables=J(2),
        loadings=J([1, 0.4]),
        factor_variance=J(1)
    )

    @test rating(factor_variance(test_factor_1)) == 1
    @test_throws TypeError Measurement(n_variables="hi", loadings=[1, 0.4], factor_variance=1)
end

