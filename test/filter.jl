@testset "filter on judgementlevels" begin
    @test length(filter(x -> rating(x, :Standardized) == true, [Model(Standardized(true)), Model(Standardized(true)), Model(Standardized(false))])) == 2
    @test rating(filter(x -> rating(x, :Empirical) == true, Study(Empirical(true)))[1], :Empirical) == true
    @test length(filter(x -> rating(x, :Empirical) == false, Study(Empirical(true)))) == 0
end




@testset "filter database on Record level" begin
    test_db = RecordDatabase()

    test_db += Record(
        rater="NH",
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
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )
    test_db += Record(
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de")
    )

    filtered_db_en = filter(x -> rating(x, :Lang) == "en", test_db, "Record")
    filtered_db_de = filter(x -> rating(x, :Lang) == "de", test_db, "Record")

    ## Check if the correct records were filtered
    @test length(filtered_db_en) == 1
    @test rating(filtered_db_en[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")], :Lang) == "en"
    @test length(filtered_db_de) == 2
    @test rating(filtered_db_de[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")], :Lang) == "de"
    ## Edge case: No record fits the filter function
    filtered_db_fr = filter(x -> rating(x, :Lang) == "fr", test_db, "Record")
    @test length(filtered_db_fr) == 0
    @test typeof(filtered_db_fr) == RecordDatabase{Base.UUID,Record}
end




@testset "filter database on Study level" begin
    test_db = RecordDatabase()

    test_db += Record(
        rater="NH",
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
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )

    test_db += Record(
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de")
    )

    ########################
    ## filtered_study_fit ##
    ########################
    filtered_study_fit = filter(x -> rating(x, :N) == 200, test_db, "Study")
    ## Check if the correct studies were filtered
    @test length(Study(filtered_study_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])) == 1
    @test rating(Study(filtered_study_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1], :N) == 200
    ## Dealing with cases where no case fits the filter function or where there is no Model in a Study:
    @test :Study ∉ keys(judgements(filtered_study_fit[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")]))
    @test :Study ∉ keys(judgements(filtered_study_fit[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a8")]))

    ##########################
    ## filtered_study_nofit ##
    ##########################
    filtered_study_nofit = filter(x -> rating(x, :N) == 2000, test_db, "Study")
    # There shouldn't be any study field left     
    for i in keys(filtered_study_nofit)
        @test :Study ∉ keys(judgements(filtered_study_nofit[i]))
    end

    ############################
    ## filtered_study_nofield ##
    ############################
    filtered_study_nofield = filter(x -> rating(x, :NoField) == 2000, test_db, "Study")
    # There shouldn't be any study field left     
    for i in keys(filtered_study_nofield)
        @test :Study ∉ keys(judgements(filtered_study_nofield[i]))
    end
end




@testset "filter database on Model level" begin
    test_db = RecordDatabase()
    test_db += Record(
        rater="NH",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Study(
            N(100),
            Model(Standardized(true), Quest("What are some best practices for managing memory usage in large-scale data processing applications?")),
            Model(Standardized(false))
        ),
        Study(
            N(200),
            Model(Standardized(false)),
            Model(Standardized(false)),
            Model(Quest("What is the role of artificial intelligence in shaping our understanding of consciousness and self-awareness?"))
        )
    )
    test_db += Record(
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        Lang("de"),
        Study(
            N(100),
            Model(Standardized(true)),
            Model(Standardized(false))
        )
    )
    test_db += Record(
        rater="NH",
        id="7548949d-b2f5-436f-8577-4237fb51d5a8",
        Lang("de"),
        Study(
            N(100)
        )
    )

    filtered_db_fit = filter(x -> rating(x, :Standardized) == true, test_db, "Model")

    ## Check if the correct studies were filtered
    @test rating(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[1], :Standardized) == true
    @test length(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])) == 1
    @test length(Model(Study(filtered_db_fit[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")])[1])) == 1
    @test rating(Model(Study(filtered_db_fit[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7")])[1])[1], :Standardized) == true
    ## Dealing with cases where no case fits the filter function or where there is no Model in a Study:
    @test :Model ∉ keys(judgements(Study(filtered_db_fit[Base.UUID("7548949d-b2f5-436f-8577-4237fb51d5a8")])[1]))
    @test :Model ∉ keys(judgements(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[2]))


    ##########################
    ## filtered_model_nofit ##
    ##########################
    filtered_db_nofit = filter(x -> certainty(x, :Standardized) < 1, test_db, "Model")
    # There shouldn't be any Model field left     
    for i in keys(filtered_db_nofit)
        record_studies = Study(filtered_db_nofit[i])
        for j in eachindex(record_studies)
            @test :Model ∉ keys(judgements(record_studies[j]))
        end
    end
end




@testset "Test Filter on Taxon level" begin
    test_db = RecordDatabase()
    test_db += Record(
        rater="NH",
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
    test_db += Record(
        rater="NH",
        id="2a129694-550c-4396-be6f-00507b1dc7bb",
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
            Model(Standardized(false)),
            Model(Standardized(false),
                NoTaxon(),
                LatentPathmodel(
                    Structural(structural_model=missing),
                    Dict(
                        :IP => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                        :IN => Measurement(n_variables=4, factor_variance=missing, loadings=missing, quest_scale=6),
                        :DN => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=7),
                        :BC => Measurement(n_variables=3, factor_variance=missing, loadings=missing, quest_scale=5),
                        :IB => Measurement(n_variables=5, factor_variance=missing, loadings=missing, quest_scale=5)
                    )
                ))
        )
    )

    filtered_db_fit = filter(x -> typeof(x) == LatentPathmodel, test_db, "Taxon")

    @test typeof(Taxon(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[1])[1]) == LatentPathmodel
    @test :Taxon ∉ keys(judgements(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7ba")])[1])[2]))
    @test typeof(Taxon(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[1])[1])[1]) == LatentPathmodel
    @test :Taxon ∉ keys(judgements(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[2])[1]))
    @test length(Taxon(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[2])[2])) == 1
    @test typeof(Taxon(Model(Study(filtered_db_fit[Base.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])[2])[2])[1]) == LatentPathmodel

    ##########################
    ## filtered_taxon_nofit ##
    ##########################
    filtered_db_nofit = filter(x -> typeof(x) == NoTaxonYet, test_db, "Taxon")
    # There shouldn't be any Taxon field left     
    for i in keys(filtered_db_nofit)
        record_studies = Study(filtered_db_nofit[i])
        for j in record_studies
            study_models = Model(j)
            for k in study_models
                @test :Taxon ∉ keys(judgements(k))
            end
        end
    end
end