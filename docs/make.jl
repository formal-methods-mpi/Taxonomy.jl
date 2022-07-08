using Taxonomy
using Documenter

DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)

makedocs(;
    modules=[Taxonomy],
    authors="Aaron Peikert, Maximilian S. Ernst, Clifford Bode, Nicklas Hafiz",
    repo="https://github.com/StructuralEquationModels/Taxonomy.jl/blob/{commit}{path}#{line}",
    sitename="Taxonomy.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://StructuralEquationModels.github.io/Taxonomy.jl",
        edit_link="devel",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorials" => ["Getting Started" => "tutorials/start.md",
                        "Something is missing" => "tutorials/missing.md"]
    ],
    doctest = false
)

deploydocs(;
    repo="github.com/StructuralEquationModels/Taxonomy.jl",
    devbranch="main",
)
