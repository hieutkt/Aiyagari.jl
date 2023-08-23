using BenchmarkTools

@benchmark bellman_value(m, v) setup=(m = AiyagariDiscrete(); v = rand(500, 3))

@time plot_results(AiyagariDiscrete(), "../figs/01_results.eps")

@time v, p = value_function_iterate(AiyagariDiscrete())
