using Documenter, DataVoyager

makedocs(
	modules = [DataVoyager],
	sitename = "DataVoyager.jl",
	analytics="UA-132838790-1",
	pages = [
        "Introduction" => "index.md"
    ]
)

deploydocs(
    repo = "github.com/queryverse/DataVoyager.jl.git"
)
