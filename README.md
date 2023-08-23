# Aiyagari.jl

[![Build Status](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/hieutkt/Aiyagari.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/hieutkt/Aiyagari.jl)

This package models the basic Aiyagari (1994) model of heterogeneous agents in discrete time.

I don't plan to register this package to General because it is made for fun.
Nevertheless, this package can be installed by

``` julia
using Pkg; Pkg.add(url="https://github.com/hieutkt/Aiyagari.jl.git")
```

## TODOs

Some ideas to improve this package that I'm thinking about.
I probably won't have time to do all these, but here they are:

- [ ] Streamline interface to conform to idiomatic Julia: Create `Solution` objects, solve models by running `solve()`, graphing with `plot()`
- [ ] Some complement functions e.g. discreterization using Tauchen’s method. Will add as I learn more
- [ ] Improve performace
- [ ] Fancy progress indicator: using [Term.jl](https://github.com/FedeClaudi/Term.jl) or [OnlineStats.jl](https://github.com/joshday/OnlineStats.jl)

