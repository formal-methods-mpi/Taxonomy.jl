@testset "Structural" begin    
    
    graph = @StenoGraph begin
        # latent regressions
        fac1 → fac2
    end

    struct_model = Structural(structural_model = graph)

    @test rating(structural_model(struct_model)) == graph
end
