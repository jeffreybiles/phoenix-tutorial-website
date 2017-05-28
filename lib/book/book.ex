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

  def get_html(section_title, chapter_title) do
    {section, chapter} = find_by_title(section_title, chapter_title)
    filepath = "#{main_path}/contents/#{section.ord}- #{section.title}/#{chapter.ord}- #{chapter.title}.md"
    markdown = File.read!(filepath)
    Earmark.as_html!(markdown)
  end

  defp contents_by_title do
    Enum.reduce(Book.contents, %{}, (fn(section, acc) ->
      new_section = Enum.reduce(section.chapters, section, (fn(chapter, acc) ->
        Map.put(acc, chapter.title, chapter)
      end))
      Map.put(acc, section.title, new_section)
    end))
  end

  defp find_by_title(section_title, chapter_title) do
    section = contents_by_title[section_title]
    chapter = section[chapter_title]
    {section, chapter}
  end
end
