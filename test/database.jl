@testset "database" begin
    # Create a new RecordDatabase instance
    my_database = RecordDatabase()

    # Test:
    first_record = Record(
        id="8f1713c9-482b-58cb-8ed4-128c03e9dafb",
        rater="AP",
        location=DOI("10.1080/10826084.2020.1735440"),
        taxons=[Measurement(n_variables=6, n_sample=113, loadings=[1, 1.19, 0.53, 0.91, 1, 1], factor_variance=4.2, error_covariances_within=[10.7, 12.9, 19])],
        spec=true,
        data=true
    )

    second_record = Record(
        id=generate_id(),
        rater="AP",
        location=DOI("10.2307/2095172"),
        taxons=[Measurement(n_variables=6, n_sample=113, loadings=[1, 1.19, 0.53, 0.91, 1, 1], factor_variance=3.2, error_covariances_within=[10.7, 12.9, 19])],
        spec=true,
        data=true
    )

    # Add the Record instances to the RecordDatabase
    push!(my_database, first_record)
    push!(my_database, second_record)
    @test length(my_database) == 2

    @test length(RecordDatabase(first_record, second_record))

    my_database = RecordDatabase()
    my_database += first_record
    @test my_database[id(first_record)] == first_record
end