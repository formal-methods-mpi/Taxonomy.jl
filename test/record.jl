@testset "record with different Judgement types" begin
    # Create a new RecordDatabase instance
    my_database = RecordDatabase()

    # Test:
    test_record = Record(
        rater = "AP",
        id = "823ddb98-f880-5691-aecc-d74b67fbe263",
        location = DOI("10.1007/s10869-019-09648-5"),
        Lang("de")
        )

    @test rating(rating(judgements(test_record)[:Lang][1])) == "de"

end
