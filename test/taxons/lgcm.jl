mylgcm_sparse = LGCM(timecoding = [0,1,2,3,4])
mylgcm = LGCM(timecoding = [0,1,2,3,4], ntimepoints = 5, npredictors = 0, nonlinearfunction = 0)
mylgcm_missing = LGCM(timecoding = J(missing))


@testset "LGCM" begin
    @test mylgcm.ntimepoints.rating == mylgcm_sparse.ntimepoints.rating == 5
    @test_throws MethodError LGCM(timecoding = "test")
    @test_throws MethodError LGCM(timecoding = 1)
    @test mylgcm_missing.ntimepoints == J(missing, 0.0, missing)
    @test_throws ArgumentError LGCM(timecoding = 1:4, ntimepoints = 3)
end
