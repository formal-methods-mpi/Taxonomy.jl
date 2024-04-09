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

@testset "filter database on Taxon level" begin
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


@testset "Test Filter on Taxon level" begin

    test_db = RecordDatabase()

    test_record = Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true),
                LatentPathmodel(
                    Structural(structural_model=missing),
                    Dict(
                        :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                        :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
                        :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                        :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
                        :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
                    )
                )
            ),
            Model(Standardized(true),
                NoTaxon()
            )
        ),
        Study(
            N(200),
            Model(Standardized(false),
            ),
            Model(Standardized(false))
        )
    )

test_db += test_record

res_db = filter(f, test_db, "Taxon")


@test length(Model(Study(res_db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])) == 2
@test length(Model(Study(res_db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[2])) == 2
@test typeof(Taxon(Model(Study(res_db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[1])[1]) == LatentPathmodel
@test :Taxon ∉ keys(judgements(Model(Study(res_db[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[2]))


## Delete! Empty fields from other JudgementLevels as well. 

## Some notes:
## How to deal with NA?

####################
## Test procedure ##
####################

# for current_study in eachindex(Study(test_record))
#     for current_model in eachindex(Model(Study(test_record)[current_study]))
#         taxons = Taxon(Model(Study(test_record)[current_study])[current_model])
#             judgements(Model(Study(test_record)[current_study])[current_model])[:Taxon] = filter(f, taxons)
#     end
# end


end