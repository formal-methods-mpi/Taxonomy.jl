@testset "database" begin
    # Create a new RecordDatabase instance
    my_database = RecordDatabase()

    # Test:
    first_record = Record(
        id="8f1713c9-482b-58cb-8ed4-128c03e9dafb",
        rater="AP",
        location=DOI("10.1080/10826084.2020.1735440"),
        Lang("de")
    )

    second_record = Record(
        id=generate_id(),
        rater="AP",
        location=DOI("10.2307/2095172"),
        Lang("en")
    )

    third_record = Record(
        id="8f1713c9-482b-58cb-8ed4-128c03e9dafc",
        rater="AP",
        location=DOI("10.1080/10826084.2020.1735440"),
        Lang("de")
    )

    # Add the Record instances to the RecordDatabase
    push!(my_database, first_record)
    push!(my_database, second_record)

    @test length(my_database) == 2
    @test length(RecordDatabase(first_record, second_record)) == 2

    my_database = RecordDatabase()
    my_database += first_record
    @test my_database[id(first_record)] == first_record
    my_database[id(second_record)] = second_record
    @test my_database[id(second_record)] == second_record
    @test_throws ArgumentError my_database[id(first_record)] = second_record
    @test_throws ArgumentError push!(my_database, first_record)
    @test_throws ArgumentError push!(my_database, third_record)

end