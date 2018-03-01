__precompile__()
module DataVoyager

using Electron, DataValues

import IteratorInterfaceExtensions, TableTraits, IterableTables, JSON

export Voyager

app = nothing

mutable struct Voyager
    w::Window

    function Voyager()
        main_html_uri = string("file:///", replace(joinpath(@__DIR__, "htmlui", "main.html"), '\\', '/'))

        if app===nothing
            app = Application()
        end

        w = Window(app, URI(main_html_uri), Dict("title"=>"Data Voyager"))

        new(w)
    end
end

function (v::Voyager)(source)
    TableTraits.isiterabletable(source) || error("Only iterable tables accepted.")

    it = IteratorInterfaceExtensions.getiterator(source)

    data_dict = Dict()

    data_dict["values"] = [Dict(c[1]=>isa(c[2], DataValue) ? (isnull(c[2]) ? nothing : get(c[2])) : c[2] for c in zip(keys(r), values(r))) for r in it]

    data = JSON.json(data_dict)

    code = "voyagerInstance.updateData($data)"

    run(v.w, code)

    return nothing
end

# function Base.getindex(v::Voyager)
#     code = "voyagerInstance.getSpec(true)"

#     content = run(v.w, code)

#     return VegaLite.VLSpec{:plot}(content)
# end

# function Base.getindex(v::Voyager, index::Int)
#     code = "voyagerInstance.getBookmarkedSpecs()"

#     content = run(v.w, code)

#     return VegaLite.VLSpec{:plot}(JSON.parse(content[index]))
# end

function Voyager(source)
    v = Voyager()

    v(source)

    return v
end

end # module
