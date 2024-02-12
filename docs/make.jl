using Taxonomy
using Documenter
using StenoGraphs

DocMeta.setdocmeta!(Taxonomy, :DocTestSetup, :(using Taxonomy); recursive=true)

makedocs(;
    modules=[Taxonomy],
    authors="Aaron Peikert, Maximilian S. Ernst, Clifford Bode, Nicklas Hafiz",
    repo="https://github.com/formal-methods-mpi/Taxonomy.jl/blob/{commit}{path}#{line}",
    sitename="Taxonomy.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://formal-methods-mpi.github.io/Taxonomy.jl",
        edit_link="devel",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorials" => ["Getting Started" => "tutorials/start.md",
                        "Something is missing" => "tutorials/missing.md",
                        "Installing, Updating, and Versioning Taxonomy.jl" => "software-versions.md"]
    ],
    doctest = true, # replace true with :fix to fix doctest
)

deploydocs(;
    repo="github.com/formal-methods-mpi/Taxonomy.jl",
    devbranch="main",
)
