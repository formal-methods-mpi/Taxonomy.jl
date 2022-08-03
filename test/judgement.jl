@testset "Judgment standard values" begin
    @test J(1.3) == Judgement(1.3, 1.0)
    @test J(missing) == Judgement(missing, 1.0)
    @test J{Int}(1, .5) == Judgement(1, .5, missing)
end

@testset "Judgment" begin
    @test convert(Judgement, 2.0) == Judgement(2.0, 1.0)
    @test_throws ArgumentError Judgement(2.0, 2.0)
    @test_throws ArgumentError Judgement(J("hi"), 2.0)
end

@testset "Judgment Getter" begin
    @test isequal(rating(J(1.3)), 1.3)
    @test isequal(certainty(J(1.3)), 1.0)
    @test isequal(location(J(1.3)), missing)
end