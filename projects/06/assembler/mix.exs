defmodule Assembler.MixProject do
  use Mix.Project

  def project do
    [
      app: :assembler,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp escript do
    [main_module: Assembler]
  end
end
