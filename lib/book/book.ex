defmodule Book do
  def contents do
    [%{
        ord: 0,
        title: "Introduction",
        chapters: [%{order: 1, title: "Intro"}]
      }, %{
        ord: 1,
        title: "Elixir Crash Course",
        chapters: [
          %{ord: 1, title: "Installing Elixir"},
          %{ord: 2, title: "Elixir Basics"},
          %{ord: 3, title: "Defining Functions"},
          %{ord: 4, title: "Pattern Matching"},
          %{ord: 5, title: "Maps"},
          %{ord: 6, title: "Atoms, Tuples, and Case"}
        ]
    }]
  end
end
