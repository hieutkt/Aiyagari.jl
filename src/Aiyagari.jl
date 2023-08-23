module Aiyagari

using UnPack: @unpack
using CairoMakie

export
    LogUtility,
    AiyagariDiscrete,
    bellman_value,
    value_function_iterate,
    plot_results

# Write your package code here.
include("utility.jl")
include("models.jl")
include("vfi.jl")
include("plots.jl")

end
