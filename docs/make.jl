using Aiyagari
using Documenter

DocMeta.setdocmeta!(Aiyagari, :DocTestSetup, :(using Aiyagari); recursive=true)

makedocs(;
    modules=[Aiyagari],
    authors="hieutkt <hieunguyen31371@gmail.com> and contributors",
    repo="https://github.com/hieutkt/Aiyagari.jl/blob/{commit}{path}#{line}",
    sitename="Aiyagari.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
