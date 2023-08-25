module Aiyagari

using UnPack: @unpack
using CairoMakie

export
    LogUtility,
    AiyagariDiscrete,
    solve,
    bellman_value,
    value_function_iterate,
    plot

# Write your package code here.
include("utility.jl")
include("models.jl")
include("solve.jl")
include("solve/vfi.jl")
include("plots.jl")

end
