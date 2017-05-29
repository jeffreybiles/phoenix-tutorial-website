defmodule Book do
  def main_path do
    "lib/book"
  end

  def contents do
    [%{
        ord: 0,
        title: "Frontmatter",
        chapters: [
          %{ord: 1, title: "Introduction (Read this first)"},
          %{ord: 2, title: "Changelog"},
          %{ord: 3, title: "Acknowledgements"}
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

  defp filepath(chapter_title) do
    chapter = find_by_title(chapter_title)
    filepath = "#{main_path}/contents/#{chapter.section_ord}- #{chapter.section_title}/#{chapter.chapter_ord}- #{chapter.chapter_title}.md"
  end

  def get_html(chapter_title) do
    filepath(chapter_title)
    |> File.read!
    |> Earmark.as_html!
  end

  # TODO: Make these work on first and last pages
  def next(chapter_title) do
    next_index = current_index(chapter_title) + 1

    contents_ordered
    |> List.to_tuple
    |> elem(next_index)
  end

  def previous(chapter_title) do
    previous_index = current_index(chapter_title) - 1

    contents_ordered
    |> List.to_tuple
    |> elem(previous_index)
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
    Enum.find_index(contents_ordered(), fn(chapter) -> chapter.chapter_title == chapter_title end)
  end

  defp find_by_title(chapter_title) do
    Enum.find(contents_ordered(), fn(chapter) -> chapter.chapter_title == chapter_title end)
  end
end
