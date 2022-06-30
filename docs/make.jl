using Taxonomie
using Documenter

DocMeta.setdocmeta!(Taxonomie, :DocTestSetup, :(using Taxonomie); recursive=true)

makedocs(;
    modules=[Taxonomie],
    authors="Aaron Peikert, Maximilian S. Ernst, Clifford Bode, Nicklas Hafiz",
    repo="https://github.com/aaronpeikert/Taxonomie.jl/blob/{commit}{path}#{line}",
    sitename="Taxonomie.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aaronpeikert.github.io/Taxonomie.jl",
        edit_link="devel",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aaronpeikert/Taxonomie.jl",
    devbranch="devel",
)
