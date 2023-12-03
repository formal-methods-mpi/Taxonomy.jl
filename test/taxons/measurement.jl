@testset "Most basic Measurement" begin
    test_factor_1 = Measurement(
        n_variables=J(2),
        loadings=J([1, 0.4]),
        factor_variance=J(1)
    )

    @test rating(factor_variance(test_factor_1)) == 1
    @test_throws TypeError Measurement(n_variables="hi", loadings=[1, 0.4], factor_variance=1)
end

@testset "Fixed Struct Tests" begin
    # Test instantiation of Fixed
    fixed_value = Fixed(0.7)
    @test fixed_value isa Fixed

    # Test the type of the wrapped value
    @test typeof(strip_fixed(fixed_value)) == Float64

    # Test the strip_fixed function with Fixed object
    @test strip_fixed(fixed_value) == 0.7

    # Test the strip_fixed function with a regular number
    regular_number = 2.5
    @test strip_fixed(regular_number) == 2.5

    test_factor_1 = Measurement(
        n_variables=J(2),
        loadings=J([1, 0.4]),
        factor_variance=J(1)
    )
    @test test_factor_1 isa Measurement

end
