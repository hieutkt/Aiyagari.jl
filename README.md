# Aiyagari.jl

[![Build Status](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/hieutkt/Aiyagari.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/hieutkt/Aiyagari.jl)

This package models the basic Aiyagari (1994) model of heterogeneous agents in discrete time.

This is basically a homework toy model made into a package. 
I made it for fun and don't plan to register this package to General.
Nevertheless, this package can be installed by

``` julia
using Pkg; Pkg.add(url="https://github.com/hieutkt/Aiyagari.jl.git")
```

Basic interaction for now is

``` julia
using Aiyagari

model = AiyagariDiscrete(n=1000) #Tweak around with the model inputs

plot_results(model, "results.png")
```

[](figs/results.png)


## TODOs

Some ideas to improve this package that I'm thinking about.
I probably won't have time to do all these, but here they are:

- [ ] Streamline interface to conform to idiomatic Julia: Create `Solution` objects, solve models by running `solve()`, graphing with `plot()`
- [ ] Some complement functions e.g. discreterization using Tauchen’s method. Will add as I learn more
- [ ] Improve performace
- [ ] Fancy progress indicator: using [Term.jl](https://github.com/FedeClaudi/Term.jl) or [OnlineStats.jl](https://github.com/joshday/OnlineStats.jl)
- [ ] A documentation site with [Documenter.jl](https://documenter.juliadocs.org/stable/), but only if it is easy enough. This is only a small package after all

