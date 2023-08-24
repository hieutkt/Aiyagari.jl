function solve(model::AiyagariDiscrete; method = :VFI)
    print("Attemting to solve the model using ")
    if method == :VFI
        printstyled("Value-function iteration", color = :blue)
        println("...")
        value_function_iterate(model)
    end
end
