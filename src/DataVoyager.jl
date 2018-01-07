__precompile__()
module DataVoyager

using Blink, DataValues

import IteratorInterfaceExtensions, TableTraits, IterableTables, JSON

export Voyager

mutable struct Voyager
    w
    function Voyager()
        w = Blink.Window()

        loadfile(w, joinpath(@__DIR__, "htmlui", "main.html"))

        new(w)
    end
end

function (v::Voyager)(source)
    TableTraits.isiterabletable(source) || error("Only iterable tables accepted.")

    it = IteratorInterfaceExtensions.getiterator(source)

    data_dict = Dict()

    data_dict["values"] = [Dict(c[1]=>isa(c[2], DataValue) ? (isnull(c[2]) ? nothing : get(c[2])) : c[2] for c in zip(keys(r), values(r))) for r in it]

    data = JSON.json(data_dict)

    jsdata = Blink.JSString(data)

    @js v.w voyagerInstance.updateData($jsdata)

    return nothing
end

function Voyager(source)
    v = Voyager()

    v(source)

    return v
end

end # module
