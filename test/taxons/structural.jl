@testset "Structural" begin    
    
    graph = @StenoGraph begin
        # latent regressions
        fac1 → fac2
    end

    struct_model = Structural(structural_model = graph)

    @test rating(structural_model(struct_model)) == graph
    @test n_sample(struct_model) == J(missing)
end
