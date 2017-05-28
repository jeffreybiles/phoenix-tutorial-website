defmodule Book do
  def contents do
    [%{
        ord: 0,
        title: "Frontmatter",
        chapters: [
          %{order: 1, title: "Introduction (Read this first)"}
          %{order: 2, title: "Changelog"},
          %{order: 3, title: "Acknowledgements"},
        ]
      }, %{
        ord: 1,
        title: "Elixir Crash Course",
        chapters: [
          %{ord: 1, title: "Installing Elixir"},
          %{ord: 2, title: "Elixir Basics"},
          %{ord: 3, title: "Defining Functions"},
          %{ord: 4, title: "Arguments and Pattern Matching"},
          %{ord: 5, title: "Maps"},
          %{ord: 6, title: "Atoms, Tuples, and Case"},
          %{ord: 7, title: "Conclusion"}
        ]
    }]
  end

  def get_html(section, chapter) do
    # grab the markdown file using section and title (grab the ord by filtering by title?)
    # parse it using earmark
    # Later: do some syntax highlighting
  end
end
