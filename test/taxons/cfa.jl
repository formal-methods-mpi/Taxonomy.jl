@testset "Factor" begin
#    @test Factor(2, [1, 0.4], 0, 0, 0, 0) == Factor(nobserved = J(2), loadings = J([1, 0.4])) ## WARUUUUM?
    @test_throws MethodError Factor(nobserved = "hi", loadings = [1, 0.4])
end
