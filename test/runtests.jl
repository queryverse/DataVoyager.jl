using DataVoyager
using DataValues
using Electron
using Test

@testset "DataVoyager" begin

source = [(a=1,b=1), (a=2,b=2)]
source2 = [(a=DataValue(1), b=DataValue{Int}()), (a=DataValue{Int}(), b=DataValue(2))]

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
