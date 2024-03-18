using Test
using Taxonomy
using Taxonomy.Judgements

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
#        Lang2(10),
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


    @newjudgement(
        Lang2,
        RecordJudgement, # Specify on which level this judgement should be used. Study level in this case.  
        """
        The number of observations in the study. Takes integer values or missings. 
        """,
        Int # Input type. In this case Integer. 
    )
    

#################
## Trying multiple filter conditions

judgements(db[Taxonomy.UUID("2a129694-550c-4396-be6f-00507b1dc7bb")])

filter_judgements(db, :Lang, x -> x == "en")



filter_judgements_3(db, :Lang, x -> x == "en")


filter_judgements = function(r::RecordDatabase, field::Symbol, comparison_func)
    filter(record -> comparison_func(rating(judgements(record.second)[field][1])), r)
end


filter_judgements_2 = function(r::RecordDatabase, fields::Vector{Symbol}, comparison_func)
    filter(record -> comparison_func([rating(judgements(record.second)[field][1]) for field in fields]), r)
end

dict = Dict(1=>"a", 2=>"b", 3=>"c")
filter(((k,v),) -> k == 1 || v == "c", dict)

filter_judgements_2(db, [:Lang, :Study], values -> all(x -> x == "en", values))
###############