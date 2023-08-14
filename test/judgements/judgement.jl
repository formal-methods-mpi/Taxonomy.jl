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