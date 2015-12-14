defmodule JapaneseHoliday.Mixfile do
  use Mix.Project

  def project do
    [
      app: :japanese_holiday,
      version: "0.0.2",
      elixir: ">= 1.0.0",
      deps: deps,
      package: package,
      description: desc
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:timex, "1.0.0-rc4"}]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      contributors: ["Joe Honzawa"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/Joe-noh/japanese_holiday"}
    ]
  end

  defp desc do
    """
    An elixir library for japanese holiday
    """
  end
end
