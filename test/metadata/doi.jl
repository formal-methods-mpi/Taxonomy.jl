@testset "DOI" begin
    @test isa(DOI("10.5281/zenodo.6719627"), Taxonomy.AbstractDOI)
    @test_throws ErrorException("unusual doi") DOI("notdoi10.5281/zenodo.6719627")
    @test isa(UnusualDOI("notdoi10.5281/zenodo.6719627"), Taxonomy.AbstractDOI)
end

@testset "DOI" begin
    @test_throws ArgumentError NoDOI(;
        url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
        author = "Ernst, Maximilian Stefan and Peikert, Aaron",
        title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
        date = Date("2022-06-24"),
        year = 2025,
        journal = "No Real Journal"
    )
    @test_throws ArgumentError NoDOI(;
        url = "https://github.com/StructuralEquationModels/StructuralEquationModels.jl",
        author = "Ernst, Maximilian Stefan and Peikert, Aaron",
        title = "StructuralEquationModels.jl: A fast and flexible SEM framework",
        journal = "No Real Journal"
    )
end