abstract type AbstractUtility end


@doc raw"""Log Utility

Type used to evaluate log utility. Log utility takes the form

```math
u(c) = \log(c)
```
where `c` is the level of consumption.
Non-positive value for `c` are assigned an utility value of `-Inf`.

"""
struct LogUtility <: AbstractUtility end

(u::LogUtility)(c) = c > 0 ? log(c) : -Inf
