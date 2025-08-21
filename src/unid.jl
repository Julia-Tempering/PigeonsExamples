# from Pigeons doc

using Pigeons
using Random
using Distributions

struct MyLogPotential
    n_trials::Int
    n_successes::Int
end

function (log_potential::MyLogPotential)(x)
    p1, p2 = x
    if !(0 < p1 < 1) || !(0 < p2 < 1)
        return -Inf64
    end
    p = p1 * p2
    return logpdf(Binomial(log_potential.n_trials, p), log_potential.n_successes)
end

Pigeons.initialization(::MyLogPotential, ::AbstractRNG, ::Int) = [0.5, 0.5]

function Pigeons.sample_iid!(::MyLogPotential, replica, shared)
    state = replica.state
    rng = replica.rng
    rand!(rng, state)
end

Pigeons.default_reference(::MyLogPotential) = MyLogPotential(0, 0)