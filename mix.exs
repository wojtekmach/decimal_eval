defmodule DecimalEval.MixProject do
  use Mix.Project

  def project() do
    [
      app: :decimal_eval,
      version: "0.1.0",
      elixir: "~> 1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application() do
    []
  end

  defp deps() do
    [
      {:decimal, "~> 1.8"}
    ]
  end
end
