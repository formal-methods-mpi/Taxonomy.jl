#using StructuralEquationModels

#@testset "Factor" begin
#    @test Factor(10, 0, 0, 0) == Factor(nobserved = J(10), nerror_covariances = J(0))
#    @test_throws MethodError Factor(nobserved = "hi", nerror_covariances = 0)
#end