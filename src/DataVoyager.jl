__precompile__()
module DataVoyager

using Blink, DataValues

import IteratorInterfaceExtensions, TableTraits, IterableTables, JSON

export Voyager

mutable struct Voyager
    w
    function Voyager()
        w = Blink.Window()
        
        loadurl(w, joinpath(@__DIR__, "htmlui", "main.html"))

        new(w)
    end
end

@generated function format_iterable_table_as_json(it::T) where T
    ET = eltype(T)

    col_names = fieldnames(ET)
    col_types = [ET.parameters[i] for i in 1:length(col_names)]

    row_output = Expr(:block)

    for (i,v) in enumerate(col_names)
        if i>1
            push!(row_output.args, :(print(buf, ", ")))
            first_column = false
        end
        push!(row_output.args, :(print(buf, "\"")))
        push!(row_output.args, :(print(buf, $("$v"))))
        push!(row_output.args, :(print(buf, "\": ")))
        if col_types[i] <: DataValue
            push!(row_output.args, quote
                if isnull(row[$i])
                    print(buf, "null")
                else
                    JSON.show_string(buf, get(row[$i]))
                end
            end)
        else
            push!(row_output.args, :(print(buf, "\"", row[$i],"\"")))
        end
    end

    quote
        buf = IOBuffer()
        print(buf, "{\"values\":[")
        for (i,row) in enumerate(it)
            if i>1
                print(buf, ",")
                first_row = false
            end
            print(buf, "{")
            $(row_output)
            print(buf, "}")
        end
        print(buf, "]}")

        return String(take!(buf))
    end
end

function (v::Voyager)(source)
    TableTraits.isiterabletable(source) || error("Only iterable tables accepted.")

    it = IteratorInterfaceExtensions.getiterator(source)

    data = format_iterable_table_as_json(it)

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
