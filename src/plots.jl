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


# function draw_invariant_wealth_and_consumption_policy(model::AiyagariSE, r_equilibrium, path)
#     @unpack a̲, β, Π, z, α, n, m, l_grid, a_grid = model
#     _, transition_matrix, consumption_fn = value_function_iterate(model, r_equilibrium)
#     a_invariant = find_invariant_distribution(transition_matrix, Π, n, m) # Plot
#     f = Figure(resolution = (1000, 400), fontsize=16)
#     ax1, ax2 = Axis(f[1, 1]), Axis(f[1, 2])
#     for i in 1:m
#         lines!(ax1, a_grid, a_invariant[:,i], label="ℓ="*string(l_grid[i]))
#         lines!(ax2, a_grid, consumption_fn[:,i], label="ℓ="*string(l_grid[i]))
#         ax1.xlabel = "Households wealth"; ax1.ylabel = "Invariant distribution"
#         ax2.xlabel = "Households wealth"; ax2.ylabel = "Optimal consumption"
#     end
#     f[1, 3] = Legend(f, ax2, "Labor states", framevisible = false)
#     save(path, f)
# end

function plot_results(model::AiyagariDiscrete, path::String)
    @unpack a̲, β, Π, n, m, l_grid, a_grid = model
    # v_fn, policy, average_capital, a_trans_matrix, c_fn
    v_fn, policy, _, transition_matrix, consumption_fn = value_function_iterate(model)
    a_invariant = find_invariant_distribution(transition_matrix, Π, n, m) # Plot
    a_change = policy .- a_grid
    # Setup plot object
    f = Figure(resolution = (1500, 400), fontsize=16)
    # Left: Value function | Right: Optimal policy function
    ax1, ax2, ax3, ax4, ax5 = Axis(f[1, 1]), Axis(f[1, 2]), Axis(f[1, 3]), Axis(f[1, 4]), Axis(f[1, 5])
    for i in 1:m
        lines!(ax1, a_grid, v_fn[:,i]    , label= "ℓ = " * string(l_grid[i]))
        lines!(ax2, a_grid, policy[:,i]  , label= "ℓ = " * string(l_grid[i]))
        lines!(ax3, a_grid, a_change[:,i], label= "ℓ = " * string(l_grid[i]))
        lines!(ax4, a_grid, a_invariant[:,i], label="ℓ="*string(l_grid[i]))
        lines!(ax5, a_grid, consumption_fn[:,i], label="ℓ="*string(l_grid[i]))
    end
    ax1.ylabel = "Value (vₜ)"; ax1.xlabel = "Current wealth (aₜ)"
    ax2.ylabel = "Optimal policy (aₜ₊₁)"; ax2.xlabel = "Current wealth (aₜ)"
    ax3.ylabel = "Change in wealth in next period (Δa)" ; ax3.xlabel = "Current wealth (aₜ)"
    ax4.xlabel = "Households wealth"; ax4.ylabel = "Invariant distribution"
    ax5.xlabel = "Households wealth"; ax5.ylabel = "Optimal consumption"
    f[2, :] = Legend(f, ax2, "Labor states",
                     orientation = :horizontal, framevisible = false)
    # Save to file
    save(path, f)
end
