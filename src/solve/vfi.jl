@doc raw"""The Bellman equation"""
function bellman_value(model::AiyagariDiscrete, v_guess)
    @unpack r, w, a̲, β, Π, n, m, a_grid, l_grid = model
    # First term: consumption utility
    cₜ = [(1 + r) * aₜ +  w * l - aₜ₊₁ for aₜ in a_grid, l in l_grid, aₜ₊₁ in a_grid]
    uₜ = LogUtility().(cₜ)
    # Expected value in the next period
    ## dimension for 𝔼v should be ℓ × aₜ₊₁, same as v_guess
    𝔼v = Array{Float64}(undef, n, m, n)
    for i in 1:n
        𝔼v[i,:,:] = Π' * v_guess'
    end
    # Compute the value function over all posible states
    vₜ = uₜ + β*𝔼v
    # Find the optimal desision for each of the current states
    optimal_decision = findmax(vₜ, dims=3)
    # v_fn = map(maximum, eachslice(vₜ, dims=(1,2), drop=true))
    v_fn = optimal_decision[1][:,:]
    error = abs.(v_guess .- v_fn)
    policy = [a_grid[idx[3]] for idx in optimal_decision[2][:,:]]
    # capital distribution
    a_transition_matrix = zeros(n, n, 3)
    for idx in optimal_decision[2][:,:]
        a_transition_matrix[idx[1], idx[3], idx[2]] = 1
    end
    # return stuffs
    return v_fn, error, policy, a_transition_matrix
end


@doc raw"""Value function iteration"""
function value_function_iterate(model::AiyagariDiscrete; max_iter=1e5, tol=1e-7)
    @unpack r, w, a̲, β, Π, a_grid, l_grid, v_initial, l_stationary_dist = model
    i = 1
    v_fn, error, policy, a_trans_matrix = bellman_value(model, v_initial)
    while any(error .>= tol) && i <= max_iter
        v_fn, error, policy, a_trans_matrix = bellman_value(model, v_fn)
        i += 1
    end
    println("Value-function iteration terminated after "*string(i)*" iterations.")
    return AiyagariDiscreteSolution(v_fn, policy, a_trans_matrix)
end
