@testset "apa() extracts correct citation from doi" begin
    @test apa(DOI("10.5281/zenodo.6719627")) == "Ernst, M. S., &amp; Peikert, A. (2022). <i>StructuralEquationModels.jl</i> (Version v0.1.0) [Computer software]. Zenodo. https://doi.org/10.5281/ZENODO.6719627"
end

@testset "json() outputs the correct json syntax form doi" begin
    json_test = json(DOI("10.5281/zenodo.6719627"))

    @test json_test isa Dict{String, Any}

    @test json_test["publisher"] == "Zenodo"
    @test json_test["issued"] == Dict{String, Any}("date-parts"=>Any[Any[2022, 6, 24]])

end

@testset "year() extracts the correct year from json" begin
    
    @test year(json(DOI("10.5281/zenodo.6719627"))) == 2022
    @test year(json(DOI("10.2307/2095172"))) == 1980
end

@testset "MetaData extracts the correct meta data from doi" begin
    @test MetaData(DOI("10.2307/2095172")).meta isa MinimalMeta
end