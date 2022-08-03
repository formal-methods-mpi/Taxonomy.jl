@testset "CFA" begin
    @test GFactor(10, 0, 0, 0) == GFactor(nobserved = J(10), nerror_covariances = J(0))
    @test_throws MethodError GFactor(nobserved = "hi", nerror_covariances = 0)
end