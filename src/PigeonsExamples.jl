module PigeonsExamples

using Pigeons

include("unid.jl")

provide_target(::Val{:unid_model}) = MyLogPotential(100_000, 50_000)

provide_target(::Val{:iid_normal_10}) = Pigeons.toy_mvn_target(10)
provide_target(::Val{:iid_normal_1000}) = Pigeons.toy_mvn_target(1000)

include("$(dirname(dirname(Base.pathof(Pigeons))))/examples/ising.jl")
Pigeons.extract_sample(state::IsingState, log_potential) = copy(vec(state.matrix))
Pigeons.sample_names(state::IsingState, _) = map(string, 1:length(state.matrix))
provide_target(::Val{:ising}) = IsingLogPotential()

end