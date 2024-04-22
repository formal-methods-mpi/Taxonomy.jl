@testset "Judgment standard values & extractors" begin
    j = J(2.0)
    @test rating(j) == 2.0
    @test certainty(j) == 1.0
    @test ismissing(comment(j))
end

@testset "Argument checks" begin
    @test_throws ArgumentError Judgement(2.0, 2.0) # certainty outside 0 > x > 1.0
    @test_throws ArgumentError Judgement(J("hi")) # too meta
    @test_throws MethodError Judgement("hi", .5, 3) # location is not a string
end

@testset "Conversion" begin
    @test convert(Judgement{Int128}, J(4.0)) == Judgement{Int128}(4)
    x = [J(1), J(2), J(2)]
    x[3] = 3
    @test x == J.(1:3)
end

@testset "Promotion" begin
    @test [J(1), J(2), 3] == J.(1:3)
end

@testset "Keyword Argument Feature" begin
    # Create FitIndices judgement
    @newjudgement(
    FitIndices,
    ModelJudgement,
    """
    Fit indices for the model. Includes chi-square, df, p-value, CFI, TLI, RMSEA. No confidence interval, use point estimate and in emergency middle of interval.
    Please add new ones if you encounter them.
    """,
    NamedTuple{(:chi_square, :df, :p_value, :CFI, :TLI, :RMSEA)}
    )
    
    # Creating an instance of FitIndices using keyword arguments
    fit_indices_instance = FitIndices(chi_square = 128.12, df = 80, p_value = "<0.01", CFI = 0.968, TLI = 0.952, RMSEA = 0.043)

    # Test if the fields are correctly assigned
    @test fit_indices_instance.rating.chi_square == 128.12
    @test fit_indices_instance.rating.df == 80
    @test fit_indices_instance.rating.p_value == "<0.01"
    @test fit_indices_instance.rating.CFI ≈ 0.968
    @test fit_indices_instance.rating.TLI ≈ 0.952
    @test fit_indices_instance.rating.RMSEA ≈ 0.043
end

@testset "Judgement Level checks" begin    
    
@newjudgement(
    Observation,
    AnyLevelJudgement, # may occur anywhere
    """
    An observation without any consequences.
    """,
    Any, # any is the default type anyway
    x -> nothing # this is the default check function anyway
)
    correct_judgement_level(Taxonomy.Judgements.judgement_level(Observation())) == true
    isnothing(check_judgement_level(Observation()))
    @test_throws ArgumentError check_judgement_level(N(100), ( StudyJudgement(), ))  
end


@testset "JudgementLevel rating" begin
    @test rating(get(Model(Standardized(true)), :Standardized)) == true
    @test rating(Model(Standardized(true)), :Standardized)
    @test rating(Study(N(100)), :N) == 100
end
