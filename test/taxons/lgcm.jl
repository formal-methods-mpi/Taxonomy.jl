@testset "LGCM" begin    
    @test_throws MethodError LGCM(n_timepoints = "hi", timecoding = [1, 0.4])
end

@testset "LGCM extractors" begin
    lgcm_model =  LGCM(n_sample = 500, n_timepoints = 6, timecoding = [0, 1, 2, 3, 4, 5], intercept = 10.2, 
    slope = 0.96, nonlinear_timecoding = [1, 2, 4, 9, 16, 25], variance_intercept = 1, variance_slope = 1, covariance_intercept_slope = 0.1,
    n_predictors = 2, predictor_paths_intercept = [2, 4], predictor_paths_slope = [3, 5])
    
    @test rating(n_timepoints(lgcm_model)) == 6
    @test rating(timecoding(lgcm_model)) == [0, 1, 2, 3, 4, 5]
    @test rating(intercept(lgcm_model)) == 10.2
    @test rating(slope(lgcm_model)) == 0.96
    @test rating(nonlinear_timecoding(lgcm_model)) == [1, 2, 4, 9, 16, 25]
    @test rating(variance_intercept(lgcm_model)) == 1
    @test rating(variance_slope(lgcm_model)) == 1
    @test rating(covariance_intercept_slope(lgcm_model)) == 0.1
    @test rating(n_predictors(lgcm_model)) == 2
    @test rating(predictor_paths_intercept(lgcm_model)) == [2, 4]
    @test rating(predictor_paths_slope(lgcm_model)) == [3, 5]
end