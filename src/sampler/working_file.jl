using Test
using Taxonomy
using Taxonomy.Judgements


@newjudgement(
    Lang2,
    RecordJudgement, # Specify on which level this judgement should be used. Study level in this case.  
    """
    The number of observations in the study. Takes integer values or missings. 
    """,
    Int # Input type. In this case Integer. 
)


    # Example Record db
    db = RecordDatabase()

    db += Record(
        rater="VK",
        id="7548949d-b2f5-436f-8577-4237fb51d5a7",
        location=DOI("10.1007/s10869-019-09648-5"),
        Lang("de"),
        Lang2(12), 
        Study(
            N(100)
        )
    )

    db += Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7ba",
        Lang("en"),
        Lang2(6),
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
        Lang2(10),
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
        Lang2(10), 
        Study(
            N(100)
        ),
        Study(
            N(200)
        )
    )




#################
## Trying multiple filter conditions

Taxonomy.rating(x::Record, field::Symbol) = rating(extract_field(x, field))
Taxonomy.rating(x::Pair{Base.UUID, Record}, field::Symbol) = rating(x.second, field)

## Currently enough to filter like I need it righ now: 
filter(record -> rating(record, :Lang) == "en" || rating(record, :Lang2) == 10, db)

## Do the same for Study level and Model level:

my_r = Record(
        rater="VK",
        id="2a129694-550c-4396-be6f-00507b1dc7bb",
        Lang("en"),
        Lang2(10),
        Study(
            N(100)
        ),
        Study(
            N(200)
        )
)

## Return dict, extract studies currently returns a vector, probably better with dict?
filter(record -> rating(my_r, :N) == 100, extract_studies(my_r)))






###################
comp_func = function(field1, field2)
    field1 == "en" && field2 == 10
end


filter_judgements_2 = function(r::RecordDatabase, comparison_function)
    filter(record -> comparison_function(rating(record.second, :Lang), rating(record.second, :Lang2)), r)
end

filter_judgements_2(db, comp_func)
filter_judgements_2(db, (field1 = :Lang, field2 = :Lang2) -> :Lang == "en" && :Lang2 == 10)




## Wanted function specification: 
filter_judgements_3(db, x -> :Lang == "en" && :Lang2 == 10)



