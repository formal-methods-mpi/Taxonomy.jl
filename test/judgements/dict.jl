@testset "judgement_dict works for different types" begin

    test_dict = judgement_dict(
        Measurement(n_variables=2, loadings=[0.53, 0.95], factor_variance=0.16),
        Measurement(n_variables=2, loadings=[0.53, 0.95], factor_variance=0.16),
        Study(N(200, 1)),
        N(300, 1),
        Lang("de", 1)
    )

    @test test_dict[:N][1] == N(300, 1)
    @test test_dict[:Measurement][1] isa Measurement
    @test rating(test_dict[:Measurement][1].loadings) == [0.53, 0.95]
    @test test_dict[:Study][1] isa Study
    @test test_dict[:Lang][1] == Lang("de", 1)
end