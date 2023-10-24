using Taxonomy, Test
include("../../src/judgements/Judgements.jl")
using .Judgements


@testset "Simple Study example provides the expected output" begin
    simple_study_test_judgements = judgements(Study(N(1000, 1), Empirical(true, 1)))
    @test typeof(simple_study_test_judgements[:N][1]) == N{Int64}
    @test typeof(simple_study_test_judgements[:Empirical][1]) == Empirical{Bool}
end

@testset "Study() can not take Judgements of RecordLevel typpe" begin
    @test_throws ArgumentError Study(Lang("de", 1))
end

