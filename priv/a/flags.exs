defmodule A.Flags do
  # Because we're evaluating AST from the main module,
  # This stuff can just as well be in import from the main project.
  defstruct [:diligence, :nuance, :comprehension]

  def callback(run_single, _run_multi) do
    nuance = []
    nuance = performance_check(run_single) ++ nuance
    # nuance = [...
    comprehension = []
    # comprehension = layer_order_check_simple(run_single) ++ comprehension
    # comprehension = [...
    diligence = []
    # diligence = [...
    %__MODULE__{diligence: diligence, nuance: nuance, comprehension: comprehension}
  end

  defp performance_check(run_single) do
    {score, stderr} = run_single.("perf_2_huge.json")
    acc = []
    acc = [{"two huge towers", if stderr || score < 10 do
      0
    else
      1
    end}] ++ acc
    {score, stderr} = run_single.("perf_indecision.json")
    acc = [{"layer check overload", if stderr || score <= 1_000 do
      0
    else
      1
    end}] ++ acc
    acc
  end
end
