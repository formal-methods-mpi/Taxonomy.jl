mylgcm_sparse = LGCM(timecoding = [0,1,2,3,4])
mylgcm = LGCM(timecoding = [0,1,2,3,4], ntimepoints = 5, npredictors = 0, nonlinearfunction = 0)
mylgcm_missing = LGCM(timecoding = missing)
mylgcm_unitrange = LGCM(timecoding = 1:4)


@testset "LGCM" begin
    @test mylgcm.ntimepoints.rating == mylgcm_sparse.ntimepoints.rating == 5
    @test_throws DomainError LGCM(timecoding = "test")
    @test_throws DomainError LGCM(timecoding = 1)
    @test mylgcm_missing.ntimepoints == J(missing, 1.0, missing)
    @test mylgcm_unitrange.ntimepoints.rating == 4
end
