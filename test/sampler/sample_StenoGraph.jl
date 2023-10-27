## Define Test objects:
graph_1 = StenoGraphs.@StenoGraph begin
    # latent regressions
    fac1 → fac2
end

struct NodeLabel_2 <: NodeModifier
    l
end
graph_2 = StenoGraphs.@StenoGraph begin
    # latent regressions
    fac1 → fac2^NodeLabel_2("Home an der Spree")
end

latent_path_example_1 = LatentPathmodel(
    Structural(n_sample = 12, structural_graph = graph_1),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)

latent_path_example_2 = LatentPathmodel(
    Structural(n_sample = 12, structural_graph = graph_2),
    Dict(
        :fac1 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6),
        :fac2 => Measurement(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.6)
    )
)

@testset "extract stenoGraphs from Taxons" begin
    @test extract_StenoGraph([latent_path_example_1, latent_path_example_2]) == [graph_1, graph_2]
end

@testset "sample StenoGraph" begin
    @test sample_steno(graph_1, 1) == graph_1
    @test sample_steno([graph_1, missing], 1) == [graph_1]
    @test ismissing(sample_steno([missing, missing], 1)) == true
    Random.seed!(42)
    @test sample_steno([graph_1, graph_2], 2) == [graph_2, graph_1]
    @test_throws MethodError sample_steno(1, 2)

end

@testset "sample random StenoGraph from a vector of taxons" begin
    Random.seed!(666)
    @test sample_StenoGraph([latent_path_example_1, latent_path_example_2]) == [graph_2]
    @test sample_StenoGraph([latent_path_example_1, latent_path_example_2], 5) == [graph_1, graph_2, graph_1, graph_1, graph_2]
end