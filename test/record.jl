@testset "record only with Judgements on the record level" begin
    test_record = Record(
        rater = "AP",
        id = "823ddb98-f880-5691-aecc-d74b67fbe263",
        location = DOI("10.1007/s10869-019-09648-5"),
        Lang("de")
        )

    @test rating(rating(judgements(test_record)[:Lang][1])) == "de"
end


@testset "record with Study() nested inside" begin
# Test:
    record_test = Record(
        rater = "AP",
        id = "823ddb98-f880-5691-aecc-d74b67fbe263",
        location = DOI("10.1007/s10869-019-09648-5"),
        Lang( #This is the Judgement we defined earlier. Within it, we can input the value, the certainty and a comments like before: 
            "de",
            0.5, # not clear what language the paper has
            "abstract in both de and en", # because the abstract exists in both english and german
        ), 
        Study(
            N(100, 0.8, "the abstract says 120 but table 1 is saying 100")
        )
    )

    @test judgements(record_test)[:Study][1] isa Study
end
