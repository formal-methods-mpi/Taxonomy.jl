using Taxonomy
using Test
using Documenter

@testset "Taxonomy.jl" begin
    if VERSION ≥ v"1.7"
        DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)
        doctest(Taxonomy)
    end
    
    include("metadata/doi.jl")
    include("judgement.jl")
    include("taxons/lgcm.jl")
end
