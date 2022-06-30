@testset "DOI" begin
    @test isa(DOI("10.5281/zenodo.6719627"), Taxonomy.AbstractDOI)
    @test_throws ErrorException("unusual doi") DOI("notdoi10.5281/zenodo.6719627")
    @test isa(UnusualDOI("notdoi10.5281/zenodo.6719627"), Taxonomy.AbstractDOI)
end