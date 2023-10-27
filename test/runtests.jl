using Taxonomy
using Test
using Documenter
using StenoGraphs
using Random

@testset "Taxonomy.jl" begin
    if VERSION ≥ v"1.7"
        DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)
        doctest(Taxonomy)
    end
    
    include("metadata/doi.jl")
    include("judgement.jl")
    include("sampler/sample_StenoGraph.jl")
    include("taxons/simple_lgcm.jl")
    include("taxons/measurement.jl")
    include("taxons/structural.jl")
    include("extractors.jl")
    include("database.jl")
end
