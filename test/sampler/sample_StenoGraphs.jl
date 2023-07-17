@testset "sample StenoGraph" begin
    graph_1 = StenoGraphs.@StenoGraph begin
        # latent regressions
        fac1 → fac2
    end
    
    struct NodeLabel <: NodeModifier
        l
    end
    graph_2 = StenoGraphs.@StenoGraph begin
        # latent regressions
        fac1 → fac2^NodeLabel("Home an der Spree")
    end
        
    @test sample_StenoGraph(graph_1, 1) == graph_1
    @test sample_StenoGraph([graph_1, missing], 1) == [graph_1]
    @test ismissing(sample_StenoGraph([missing, missing], 1)) == true
    Random.seed!(42)
    @test sample_StenoGraph([graph_1, graph_2], 2) == [graph_2, graph_1]
    @test_throws MethodError sample_StenoGraph(1, 2)

end

@testset "extract stenoGraphs from Taxons" begin
    graph_1 = StenoGraphs.@StenoGraph begin
        # latent regressions
        fac1 → fac2
    end

    struct NodeLabel <: NodeModifier
        l
    end
    graph_2 = StenoGraphs.@StenoGraph begin
        # latent regressions
        fac1 → fac2^NodeLabel("Home an der Spree")
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
      
    @test extract_StenoGraph([latent_path_example_1, latent_path_example_2]) == [graph_1, graph_2]

end
