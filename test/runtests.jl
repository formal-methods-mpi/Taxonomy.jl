using Taxonomy
using Taxonomy.Judgements
using Test
using Documenter
using StenoGraphs

@testset "Taxonomy.jl" begin
   if (VERSION ≥ v"1.7") & false # dont run doctests, they already run with the documentation CI
       DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)
       doctest(Taxonomy)
   end
    
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
    include("sampler/sample_study.jl")
end
