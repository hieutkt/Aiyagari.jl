@doc raw"""The Bellman equation"""
function bellman_value(model::AiyagariDiscrete, v_guess::Array{Float64,2}, uₜ::Array{Float64,3}; terminate=false)
    @unpack r, w, a̲, β, Π, n, m, a_grid, l_grid = model
    # Expected value in the next period
    @inbounds  𝔼v = Π' * v_guess' |> v -> reshape(repeat(v, inner=(n,1)), n, m, n)
    # Compute the value function over all posible states
    vₜ = uₜ + β*𝔼v
    # Find the optimal desision for each of the current states
    v_iterated = dropdims(maximum(vₜ, dims=3), dims=3)
    # Only compute the policy functions when terminating
    # If not, returns the error value and the iterated value function
    if terminate
        optimal_policy_indices = findall(vₜ .== v_iterated)
        a_transition_matrix = zeros(n, n, m)
        optimal_policy = zeros(n, m)
        for idx in optimal_policy_indices
            optimal_policy[idx[1], idx[2]] = a_grid[idx[3]]
            a_transition_matrix[idx[1], idx[3], idx[2]] = 1
        end
        return AiyagariDiscreteSolution(v_iterated, optimal_policy, a_transition_matrix )
    else
        error = abs.(v_guess .- v_iterated)
        return v_iterated, error
    end
end


@doc raw"""Value function iteration"""
function value_function_iterate(model::AiyagariDiscrete; max_iter=1e5, tol=1e-7)
    @unpack r, w, a̲, β, Π, a_grid, l_grid, v_initial, l_stationary_dist, n, m = model
    i = 1
    # Caching the first term in the bellman equation: consumption utility
    cₜ = [(1 + r) * aₜ +  w * l - aₜ₊₁ for aₜ in a_grid, l in l_grid, aₜ₊₁ in a_grid]
    uₜ = LogUtility().(cₜ)
    # Starts the iteration process
    v_fn, error = bellman_value(model, v_initial, uₜ)
    while any(error .>= tol) && i <= max_iter
        v_fn, error = bellman_value(model, v_fn, uₜ)
        i += 1
    end
    println("Value-function iteration terminated after " * string(i+1) * " iterations.")
    return bellman_value(model, v_fn, uₜ, terminate=true)
end
