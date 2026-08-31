using Documenter, DataVoyager

makedocs(
	modules=[DataVoyager],
	sitename="DataVoyager.jl",
	format = Documenter.HTML(analytics = "UA-132838790-1"),
	warnonly = [:missing_docs],
	pages=[
        "Introduction" => "index.md"
    ]
)

deploydocs(
    repo="github.com/queryverse/DataVoyager.jl.git"
)
