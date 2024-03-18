  # Example Record db
  db = RecordDatabase()

  db += Record(
      rater="VK",
      id="7548949d-b2f5-436f-8577-4237fb51d5a7",
      location=DOI("10.1007/s10869-019-09648-5"),
      Lang("de"),
      Study(
          N(100)
      )
  )

  db += Record(
      rater="VK",
      id="2a129694-550c-4396-be6f-00507b1dc7ba",
      Lang("en"),
      Study(
          N(100)
      ),
      Study(
          N(200)
      )
  )

  db += Record(
      rater="VK",
      id="2a129694-550c-4396-be6f-00507b1dc7bb",
      Lang("en"),
      Study(
          N(100)
      ),
      Study(
          N(200)
      )
  )


  db += Record(
      rater="VK",
      id="2a129694-550c-4396-be6f-00507b1dc7bc",
      Study(
          N(100)
      ),
      Study(
          N(200)
      )
  )

@testset "filter judgements" begin

    @test length(filter_judgements(db, :Lang, x -> x == "en")) == 2
    @test Taxonomy.UUID("7548949d-b2f5-436f-8577-4237fb51d5a7") in keys(filter_judgements(db, :Lang, x -> x == "de"))
end


@testset "return field" begin
    my_r = Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        location=DOI("10.1007/s10869-019-09648-5"),
        Lang("de"),
        Study(
            N(100)
        ),
        Study(
            N(200)
        )
    )

    @test rating(extract_field(my_r, :Lang)[1]) == "de"
end

@testset "judgement sampling" begin
    @test rating(extract_values(db, :Lang)[2]) == "en"
end

