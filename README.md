# Aiyagari.jl

[![Build Status](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/hieutkt/Aiyagari.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/hieutkt/Aiyagari.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/hieutkt/Aiyagari.jl)

This package models the basic Aiyagari (1994) model of heterogeneous agents in discrete time.
This classic model for examining inequality and wealth distribution considers a world with incomplete markets, where economic agents are credit-constrained and therefore cannot perfectly insure themselves against idiosyncratic income shocks.

This is basically a homework toy model made into a package. 
I made this for fun and thus don't plan to register this package to General.
Nevertheless, this package can be installed by running the following command in a Julia REPL:

``` julia
using Pkg; Pkg.add(url="https://github.com/hieutkt/Aiyagari.jl.git")
```

For now, basic interactions are as follow:

``` julia
using Aiyagari

model = AiyagariDiscrete(n=1000) #Tweak around with the model inputs

plot_results(model, "results.png")
```

![Sample results output](/figs/results.png)


## TODOs

I have some ideas to improve this package.
I probably won't get around to do them all (as the fall semester is starting) but here they are:

- [ ] Streamline interface to conform with idiomatic Julia: Create `Solution` types, solve models by running `solve()`, graphing with `plot()`
- [ ] Write atomic plotting functions that do one thing well. Make them composable like with the rest of the [Makie.jl](https://github.com/MakieOrg/Makie.jl) ecosystem
- [ ] Some supporting functionalities e.g. discretization using Tauchen’s method. Will add as I learn more
- [ ] Improve performace: This implementation currently solves the simpliest models (3 income states, 1000 wealth grid) in about 3-4 seconds. There is much room to improve.
- [ ] Fancy progress indicator: using [Term.jl](https://github.com/FedeClaudi/Term.jl) or [OnlineStats.jl](https://github.com/joshday/OnlineStats.jl)
- [ ] A documentation site with [Documenter.jl](https://documenter.juliadocs.org/stable/), but only if it is easy enough. This is only a small package after all

