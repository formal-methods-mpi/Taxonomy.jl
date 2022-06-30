using Taxonomie
using Test
using Documenter

@testset "Taxonomie.jl" begin
    DocMeta.setdocmeta!(Taxonomie, :DocTestSetup, :(using Taxonomie); recursive=true)
    doctest(Taxonomie)
    
    include("metadata/doi.jl")
end
