@testset "record with different Judgement types" begin
    # Create a new RecordDatabase instance
    my_database = RecordDatabase()

    # Test:
    test_record = Record(
        judgements=Dict(
            "Empirical" => JudgementBool(true),
            "Language" => JudgementString("en"),
            "Taxon" => J(Measurement(n_variables=6, n_sample=113, loadings=[1, 1.19, 0.53, 0.91, 1, 1], factor_variance=4.2, error_covariances_within=[10.7, 12.9, 19])))
    )

    @test rating(get(judgements(test_record), "Empirical", 3)) == true
    @test rating(get(judgements(test_record), "Language", 3)) == "en"

end