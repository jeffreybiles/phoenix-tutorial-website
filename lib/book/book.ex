defmodule Book do
  def contents do
    [%{
        ord: 0,
        title: "Frontmatter",
        chapters: [
          %{ord: 1, title: "Introduction (Read this first)"},
          %{ord: 2, title: "Changelog"},
          %{ord: 3, title: "Acknowledgements"},
          %{ord: 4, title: "Copyright and License"}
        ]
      }, %{
        ord: 1,
        title: "Elixir Crash Course",
        chapters: [
          %{ord: 1, title: "Installing Elixir"},
          %{ord: 2, title: "Elixir Basics"},
          %{ord: 3, title: "Defining Functions"},
          %{ord: 4, title: "Arguments and Pattern Matching"},
          %{ord: 5, title: "Maps and Immutability"},
          %{ord: 6, title: "Atoms, Tuples, and Case Statements"},
          %{ord: 7, title: "Conclusion"}
        ]
      }, %{
        ord: 2,
        title: "Customizing Your First Phoenix Page",
        chapters: [
          %{ord: 1, title: "Installing Phoenix"},
          %{ord: 2, title: "Beam Me Up (Version Control and Deployment)"},
          %{ord: 3, title: "Customizing Our Page"},
          %{ord: 4, title: "A New Page"},
          %{ord: 5, title: "Passing Data"},
          %{ord: 6, title: "Links and Loops"}
        ]
      }, %{
        ord: 3,
        title: "Generating a Resource",
        chapters: [
          %{ord: 1, title: "Generating Materials"},
          %{ord: 2, title: "Materials Index"},
          %{ord: 3, title: "Materials Show"},
          %{ord: 4, title: "Deleting a Material"},
          %{ord: 5, title: "Creating a Material"},
          %{ord: 6, title: "Editing a Material"},
          %{ord: 7, title: "Adding a Field"}
        ]
      }, %{
        ord: 99,
        title: "Appendices",
        chapters: [
          %{ord: 1, title: "Use, Import, Alias"},
        ]
      }]
  end

  defp filepath(chapter_title) do
    chapter = find_by_title(chapter_title)
    "lib/book/contents/#{chapter.section_ord}- #{chapter.section_title}/#{chapter.chapter_ord}- #{chapter.chapter_title}.md"
  end

  def get_html(chapter_title) do
    filepath(chapter_title)
    |> File.read!
    |> Earmark.as_html!
    |> html_processing
  end

  def html_processing(html) do
    html
    |> String.replace("\"", "'")
    |> String.replace(~r/<img src='\.\.\/images\/(\d+\.*\d+)\/([^']+)'/u, "<img src='/images/\\g{1}/\\g{2}'")
    |> String.replace(~r/<img ([^>]+)>\s*{ width=(\d+)% }/, "<img \\g{1} style='width: \\g{2}%'>")
  end

  # TODO: Make these work on first and last pages
  def next(chapter_title) do
    next_index = current_index(chapter_title) + 1
    Enum.at(contents_ordered(), next_index)
  end

  def previous(chapter_title) do
    previous_index = current_index(chapter_title) - 1
    if (previous_index < 0), do: nil, else: Enum.at(contents_ordered(), previous_index)
  end

  defp contents_ordered do
    Book.contents
    |> Enum.map(fn(section) ->
      Enum.map(section.chapters, fn(chapter) ->
        %{section_ord: section.ord,
          section_title: section.title,
          chapter_ord: chapter.ord,
          chapter_title: chapter.title}
      end)
    end)
    |> List.flatten
  end

  defp current_index(chapter_title) do
    Enum.find_index(contents_ordered(), fn(chapter) -> chapter.chapter_title == chapter_title end) || 0
  end

  defp find_by_title(chapter_title) do
    Enum.find(contents_ordered(), fn(chapter) -> chapter.chapter_title == chapter_title end)
  end
end
