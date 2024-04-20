defmodule POCService.MixProject do
  use Mix.Project

  def project do
    [
      app: :poc_service,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :kaffe],
      mod: {POCService.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:kaffe, "~> 1.25"},
      {:logger_json, "~> 5.1"},
      {:mongodb_driver, "~> 1.4"},
      {:plug_cowboy, "~> 2.7"}
    ]
  end
end
