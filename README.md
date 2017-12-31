# DataVoyager

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/davidanthoff/DataVoyager.jl.svg?branch=master)](https://travis-ci.org/davidanthoff/DataVoyager.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/ufpk7xf3h94nihtj/branch/master?svg=true)](https://ci.appveyor.com/project/davidanthoff/datavoyager-jl/branch/master)
[![DataVoyager](http://pkg.julialang.org/badges/DataVoyager_0.6.svg)](http://pkg.julialang.org/?pkg=DataVoyager)
[![codecov.io](http://codecov.io/github/davidanthoff/DataVoyager.jl/coverage.svg?branch=master)](http://codecov.io/github/davidanthoff/DataVoyager.jl?branch=master)

## Overview

This package provides julia integration for the [Voyager](https://github.com/vega/voyager) data exploration tool.

## Getting Started

DataVoyager.jl can be used for data exploration. It can help you visualize and understand any data that is in a tabular format.

You can install the package via the julia package manager:
````julia
Pkg.add("DataVoyager")
````

You create a new voyager window by calling ``Voyager``:
````julia
using DataVoyager

v = Voyager()
````

By itself this is not very useful, the next step is to load some data into voyager. Lets assume your data is in a ``DataFrame``:
````julia
using DataFrames, DataVoyager

data = DataFrame(a=[rand(100), randn(100)])

v = Voyager(data)
````

You can also use the pipe to load data into voyager:
````julia
using DataFrames, DataVoyager

data = DataFrame(a=[rand(100), randn(100)])

v = data |> Voyager()
````

You can load any [IterableTables.jl](https://github.com/davidanthoff/IterableTables.jl) source into voyager, i.e. not just ``DataFrame``s. For example, you can load some data from a CSV file with [CSVFiles.jl](https://github.com/davidanthoff/CSVFiles.jl), filter them with [Query.jl](https://github.com/davidanthoff/Query.jl) and then visualize the result with voyager:
````julia
using FileIO, CSVFiles, Query, DataVoyager

load("data.csv") |> @filter(_.age>30) |> Voyager()
````
In this example the data is streamed directly into voyager and at no point is any ``DataFrame`` allocated.
