using Taxonomie
using Test

@testset "Taxonomie.jl" begin
    DocMeta.setdocmeta!(Taxonomie, :DocTestSetup, :(using Taxonomie); recursive=true)
    doctest(Taxonomie)
    
    include("metadata/doi.jl")
end
