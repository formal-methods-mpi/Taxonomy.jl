using Taxonomy
using Taxonomy.Judgements
using Test
using Documenter
using StenoGraphs

@testset "Taxonomy.jl" begin
 #   if VERSION ≥ v"1.7"
 #       DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)
 #       doctest(Taxonomy)
 #   end
 ## Don't use Doctests rn
    
    include("metadata/doi.jl")
    include("judgements/judgement.jl")
    include("study.jl")
    include("record.jl")
    include("taxons/simple_lgcm.jl")
    include("taxons/measurement.jl")
    include("taxons/structural.jl")
    include("extractors.jl")
    include("database.jl")
    include("judgements/dict.jl")
end
