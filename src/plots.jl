function find_invariant_distribution(transition_matrix, Π, n, m)
    # Simulating the transition
    error_term = Inf
    a_invariant = ones(n, m) ./ (n * m)
    while error_term >= 1.0e-5
        a_new = vcat([a_invariant[:,i]' * transition_matrix[:,:,i] for i in 1:3]...)' * Π
        error_term = abs.(a_new - a_invariant) |> sum
        a_invariant = a_new
    end
    return a_invariant
end


function plot_results(sol::AiyagariDiscreteSolution, model::AiyagariDiscrete, path::String)
    @unpack a̲, β, Π, r, w, n, m, l_grid, a_grid = model
    a_invariant = find_invariant_distribution(sol.transition_matrix, Π, n, m)
    a_change = sol.optimal_policy .- a_grid
    # Optimal consumption policy
    consumption_fn = [(1 + r) * aₜ +  w * l for aₜ in a_grid, l in l_grid] .- sol.optimal_policy
    # Setup plot object
    f = Figure(resolution = (1500, 400), fontsize=16)
    # Left: Value function | Right: Optimal policy function
    ax1, ax2, ax3, ax4, ax5 = Axis(f[1, 1]), Axis(f[1, 2]), Axis(f[1, 3]), Axis(f[1, 4]), Axis(f[1, 5])
    for i in 1:m
        lines!(ax1, a_grid, sol.value_function[:,i]    , label= "ℓ = " * string(l_grid[i]))
        lines!(ax2, a_grid, sol.optimal_policy[:,i]  , label= "ℓ = " * string(l_grid[i]))
        lines!(ax3, a_grid, a_change[:,i], label= "ℓ = " * string(l_grid[i]))
        lines!(ax4, a_grid, a_invariant[:,i], label="ℓ="*string(l_grid[i]))
        lines!(ax5, a_grid, consumption_fn[:,i], label="ℓ="*string(l_grid[i]))
    end
    ax1.ylabel = "Value (vₜ)"; ax1.xlabel = "Current wealth (aₜ)"
    ax2.ylabel = "Optimal policy (aₜ₊₁)"; ax2.xlabel = "Current wealth (aₜ)"
    ax3.ylabel = "Change in wealth in next period (Δa)" ; ax3.xlabel = "Current wealth (aₜ)"
    ax4.xlabel = "Households wealth (aₜ)"; ax4.ylabel = "Invariant distribution"
    ax5.xlabel = "Households wealth (aₜ)"; ax5.ylabel = "Optimal consumption (cₜ)"
    f[2, :] = Legend(f, ax2, "Labor states",
                     orientation = :horizontal, framevisible = false)
    # Save to file
    save(path, f)
end
