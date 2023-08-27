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
- Module managements
    + [ ] `Pkg` supports [supports multi-package repositories](https://github.com/JuliaLang/Juleps/issues/8#issuecomment-400829383). It might be useful to have one large repository that contains the core functions that is being used in most modelling workflows, and then having specific components e.g. `AiyagariDiscrete()` be sub-modules that one only loads when needed. I like the idea of having a modular system of economics computational tools. Need to think more about this but look for big projects like [Makie.jl](https://github.com/MakieOrg/Makie.jl) or [FasiAI.jl](https://github.com/FluxML/FastAI.jl) to see how they implement it.
    + [ ] In such case, we can lazily pre-compile costly components of the package (For example, plotting with `CairoMakie.jl`, optimizations with `JuMP.jl`). [Require.jl](https://github.com/JuliaPackaging/Requires.jl) seems to be suitable for this purpose, but I'm not sure if it is needed.
- Graphing capabilities
    + [x] Drawing graphs with a dwim `plot()` function which takes a model solution and return a plot object
    + [ ] Write atomic plotting functions that do only one thing and do it well. Make them composable like with the rest of the [Makie.jl](https://github.com/MakieOrg/Makie.jl) ecosystem
- Some supporting functionalities 
    + [ ] Discretization using Tauchen’s method.
    + [ ] Markov matrices and operations. Computation of invariant distributions is already there but is in rough stages. Might as well importing from some library if implement it well.
- Improve performance for VFI: 
    + [x] Caching the utility matrix: The first term in the Bellman equation is independent of the value function $v_t$, so we should compute them only once! Benchmark improved from `2.566 s ± 3.405 ms` to `2.002 s ± 39.059 ms`.
    + [x] After some more optimizations this implementation now solve the simpliest models (3 income states, 500 wealth grid) to `858.676 ms ±  22.632 ms`.
    + [x] Only compute the optimal policy for the last iteration: `506.230 ms ±  42.657 ms`
- Documentations:
    + [ ] Write docs for everything
    + [ ] A documentation site with [Documenter.jl](https://documenter.juliadocs.org/stable/), but only if it is easy enough. This is only a small package after all
- Miscellaneous
    + [ ] Fancy progress indicator: using [Term.jl](https://github.com/FedeClaudi/Term.jl), [OnlineStats.jl](https://github.com/joshday/OnlineStats.jl) or [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl)

