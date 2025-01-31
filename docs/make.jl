using Documenter: Documenter, makedocs, deploydocs
using CommonDataModel: CommonDataModel

makedocs(;
    modules=[CommonDataModel],
    repo="https://github.com/JuliaGeo/CommonDataModel.jl/blob/{commit}{path}#{line}",
    sitename="CommonDataModel.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://juliageo.github.io/CommonDataModel.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaGeo/CommonDataModel.jl",
)
