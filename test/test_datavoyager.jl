@testitem "DataVoyager" begin
    using DataValues
    using Electron

    Electron.prep_test_env()

    try
        source = [(a = 1, b = 1), (a = 2, b = 2)]
        source2 = [(a = DataValue(1), b = DataValue{Int}()), (a = DataValue{Int}(), b = DataValue(2))]

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
    finally
        # Close every window opened during the test. Each window is closed at most
        # once, from a snapshot of the window list: `close(app)` instead loops over
        # `windows(app)`, and re-closes a window whose asynchronous "windowclosed"
        # notification has not arrived yet -- Electron never replies to a close for a
        # window it already destroyed, so that call blocks forever.
        for app in Electron.applications()
            app.exists || continue
            for win in copy(Electron.windows(app))
                win.exists && close(win)
            end
        end
    end
end
