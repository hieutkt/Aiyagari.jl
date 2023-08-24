###############################################################################
#                                 MODEL TYPES                                 #
###############################################################################


abstract type EconomicsModel end


@doc raw"""The basic Aiyagari (1994) model of heterogeneous agents in discrete time.

This classic model for examining inequality and wealth distribution considers a world with incomplete markets, where economic agents are credit-constrained and therefore cannot perfectly insure themselves against idiosyncratic income shocks.

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
Base.@kwdef struct AiyagariDiscrete <: EconomicsModel
    r::Float64 = 0.0505                                      #Interest rates
    w::Float64 = 0.0560                                      #Labor wage
    a̲::Float64 = 0.1                                         #Borrowing constraint (lower -> more constrained)
    β::Float64 = 0.95                                        #Discount rate
    Π::Matrix{Float64} = [0.5 0.4 0.1                          #Transition matrix
                          0.2 0.7 0.1
                          0.2 0.2 0.6]
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


###############################################################################
#                                SOLUTION TYPES                               #
###############################################################################


abstract type ModelSolution end


struct AiyagariDiscreteSolution <: ModelSolution
    value_function::Array{Float64}
    optimal_policy::Array{Float64}
    transition_matrix::Array{Float64}
end


function Base.show(io::IO, sol::AiyagariDiscreteSolution)
    print("The Aiyagari (1994) model in discrete time is solved.")
end
