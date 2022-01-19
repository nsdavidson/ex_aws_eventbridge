defmodule ExAws.EventBridge.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :ex_aws_eventbridge,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: ExAws.EventBridge,
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.1"},
      {:jason, "~> 1.1"},
      {:hackney, "~> 1.1"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      description: "EventBridge service module for ex_aws",
      files: ["lib", "mix.exs", "README*", "CHANGELOG*"],
      maintainers: ["Nolan Davidson"],
      licenses: ["MIT"],
      links: %{
        Changelog: "https://hexdocs.pm/ex_aws_eventbridge/changelog.html",
        GitHub: "https://github.com/nsdavidson/ex_aws_eventbridge"
      }
    ]
  end

  defp docs() do
    [
      extras: [
        "CHANGELOG.md",
        "README.md"
      ],
      main: "readme",
      source_url: "https://github.com/nsdavidson/ex_aws_eventbridge",
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
