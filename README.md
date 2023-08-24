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
sol = solve(model)
plot_results(sol, model, "results.png")
```

![Sample results output](/figs/results.png)


## TODOs

I have some ideas to improve this package.
I probably won't get around to do them all (as the fall semester is starting) but here they are:

- Streamline interface to conform with idiomatic Julia:
    + [x] Proper `display()` properties for models objects
    + [x] Create abstract `EconomicsModel` and `ModelSolution` types
    + [x] Solve models by running `solve()` which takes a model and returns a solution
    + [ ] Drawing graphs with various `plot()` functions which takes a model solution 
- Graphing capabilities
    + [ ] Write atomic plotting functions that do only one thing and do it well. Make them composable like with the rest of the [Makie.jl](https://github.com/MakieOrg/Makie.jl) ecosystem
- Some supporting functionalities 
    + [ ] Discretization using Tauchen’s method.
    + [ ] Markov matrices and operations. Computation of invariant distributions is already there but is in rough stages. Might as well importing from some library if implement it well.
- Improve performace: 
    + [ ] This implementation currently solves the simpliest models (3 income states, 1000 wealth grid) in about 3-4 seconds. There is much room to improve.
- Documentations:
    + [ ] Write docs for everything
    + [ ] A documentation site with [Documenter.jl](https://documenter.juliadocs.org/stable/), but only if it is easy enough. This is only a small package after all
- Miscellaneous
    + [ ] Fancy progress indicator: using [Term.jl](https://github.com/FedeClaudi/Term.jl), [OnlineStats.jl](https://github.com/joshday/OnlineStats.jl) or [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl)

