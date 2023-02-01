@testset "LGCM" begin    
    @test_throws MethodError LGCM(n_timepoints = "hi", timecoding = [1, 0.4])
end