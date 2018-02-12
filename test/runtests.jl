using DataVoyager
using NamedTuples
using DataValues
using Electron
using Base.Test

@testset "DataVoyager" begin

source = [@NT(a=1,b=1), @NT(a=2,b=2)]
source2 = [@NT(a=DataValue(1), DataValue{Int}()), @NT(a=DataValue{Int}(), b=DataValue(2))]

v = Voyager()
@test typeof(v.w) == Electron.Window

v = Voyager(source)
@test typeof(v.w) == Electron.Window

v(source)
@test typeof(v.w) == Electron.Window

source |> v
@test typeof(v.w) == Electron.Window

v = Voyager(source2)
@test typeof(v.w) == Electron.Window

v(source2)
@test typeof(v.w) == Electron.Window

source2 |> v
@test typeof(v.w) == Electron.Window


end
