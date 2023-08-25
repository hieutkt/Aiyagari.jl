using BenchmarkTools

@benchmark solve(model) setup=(model=AiyagariDiscrete())

plot_results(solve(AiyagariDiscrete()), AiyagariDiscrete()) |> display
