@doc raw"""The basic Aiyagari model in discrete time

# Arguments
- `r::Float64 = 0.0505`: Interest rates
- `w::Float64 = 0.0560`: Labor wage
- `a̲::Float64 = .1`: Borrowing constraint (lower -> more constrained)
- `β::Float64 = 0.95`: Discount rate
- `Π::Matrix{Float64} = [.5 .4 .1; .2 .7 .1; .2 .2 .6]`: Transition matrix
- `a_max::Float64 = 10.0`: Maximum value of a
- `n::Integer = 500`: Size of grid-search over a
- `a_grid::Array{Float64} = vec(range(-a̲, a_max, length=n))`: Asset states
- `l_grid::Array{Float64} = [0.1, 1.0, 1.25]`: Labor states
- `m::Integer = length(l_grid)`: Number of labor states
- `l_stationary_dist::Array{Float64} = adjoint(fill(1/3, 3)' * Π^100)`: Stationary distribution of labor
- `v_initial::Matrix{Float64} = zeros(n, 3)`: Initial value function

"""
Base.@kwdef struct AiyagariDiscrete
    r::Float64 = 0.0505                                      #Interest rates
    w::Float64 = 0.0560                                      #Labor wage
    a̲::Float64 = 0.1                                         #Borrowing constraint (lower -> more constrained)
    β::Float64 = 0.95                                        #Discount rate
    Π::Matrix{Float64} = [.5 .4 .1;                          #Transition matrix
                            .2 .7 .1;
                            .2 .2 .6]
    a_max::Float64 = 5.0                                    #Maximum value of a
    n::Integer = 500                                         #Size of grid-search over a
    a_grid::Array{Float64} = vec(range(-a̲, a_max, length=n)) #Asset states
    l_grid::Array{Float64} = [0.1, 1.0, 1.25]                #Labor states
    m::Integer = length(l_grid)                              #Number of labor states
    l_stationary_dist::Array{Float64} =
        adjoint(fill(1/3, 3)' * Π^100)                       #Stationary distribution of labor
    v_initial::Matrix{Float64} = zeros(n, 3)                 #Initial value function
end


function Base.show(io::IO, model::AiyagariDiscrete)
    print("Aiyagari (1994) model in discrete time with " *
        string(length(model.l_grid)) * " income states and " *
        string(model.n) * " wealth states.")
end
