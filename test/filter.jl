@testset "filter on judgementlevels" begin
    @test length(filter(x -> rating(x, :Standardized) == true, [Model(Standardized(true)), Model(Standardized(true)), Model(Standardized(false))])) == 2
    @test rating(filter(x -> rating(x, :Empirical) == true, Study(Empirical(true)))[1], :Empirical) == true
    @test length(filter(x -> rating(x, :Empirical) == false, Study(Empirical(true)))) == 0
end



@testset "filter database on Record level" begin
    test_db = RecordDatabase()

    test_db += Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true)
                  ),
            Model(Standardized(false))
        ),
        Study(
            N(200),
            Model(Standardized(false)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de")
    )

    filtered_record = filter(x -> rating(x, :Lang) == "en", test_db, Record())


    ## Check if the correct records were filtered
    @test length(filtered_record) == 1
    @test rating(filtered_record[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")], :Lang) == "en"
end

@testset "filter database on Study level" begin
    test_db = RecordDatabase()

    test_db += Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        ),
        Study(
            N(200),
            Model(Standardized(false)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de")
    )

    filtered_study = filter(x -> rating(x, :N) == 200, test_db, Study())

    ## Check if the correct studies were filtered
    @test length(Study(filtered_study[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])) == 1
    @test rating(Study(filtered_study[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1], :N) == 200

    ## Dealing with cases where no case fits the filter function or where there is no Model in a Study:
    @test length(Study(filtered_study[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")])) == 0
    @test length(Study(filtered_study[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a8")])) == 0
end


@testset "filter database on Model level" begin
    test_db = RecordDatabase()

    test_db += Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        ),
        Study(
            N(200),
            Model(Standardized(false)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de"),
        Study(
            N(100)
        )
    )

    filtered_model = filter(x -> rating(x, :Standardized) == true, test_db, Model())

    ## Check if the correct studies were filtered
    @test rating(Model(Study(filtered_model[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[1], :Standardized) == true
    @test length(Model(Study(filtered_model[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])) == 1
    @test length(Model(Study(filtered_model[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")])[1])) == 1
    @test rating(Model(Study(filtered_model[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")])[1])[1], :Standardized) == true

    ## Dealing with cases where no case fits the filter function or where there is no Model in a Study:
    @test length(Model(Study(filtered_model[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a8")])[1])) == 0
    @test length(Model(Study(filtered_model[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[2])) == 0

end
