@testset "sample StenoGraph" begin

    ## Generating two Taxons with a StenoGraph:
    factor1 = Factor(n_variables = 2, loadings = [1, 0.4], factor_variance = 0.7)
    factor2 = Factor(n_variables = 2, loadings = [0.7, 0.3], factor_variance = 1)
    
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
    
    cfa_1 = CFA(measurement_model = [factor1, factor2],
    structural_model = graph_1)
    cfa_2 = CFA(measurement_model = [factor1, factor2],
    structural_model = graph_2)
    
    ## combine:
    cfa_vec = [cfa_1, cfa_2]
    