using DataVoyager
using NamedTuples
using Blink
using Base.Test

@testset "DataVoyager" begin

source = [@NT(a=1,b=1), @NT(a=2,b=2)]

v = Voyager()
@test typeof(v.w) == AtomShell.Window

v = Voyager(source)
@test typeof(v.w) == AtomShell.Window

v(source)
@test typeof(v.w) == AtomShell.Window


source |> v
@test typeof(v.w) == AtomShell.Window

end
