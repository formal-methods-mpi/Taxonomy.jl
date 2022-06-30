using Taxonomy
using Test
using Documenter

@testset "Taxonomy.jl" begin
    DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)
    doctest(Taxonomy)
    
    include("metadata/doi.jl")
end
