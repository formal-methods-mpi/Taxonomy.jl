@testset "CFA" begin
    @test GFactor(10, 0, 0, 0) == GFactor(nobserved = J(10), nerror_covariances = J(0))
end