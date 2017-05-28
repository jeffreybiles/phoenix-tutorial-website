defmodule EbookGenerator do
  def generate_markdown do
    {:ok, header_footer_data} = File.read("#{Book.main_path}/header_footer.md")
    file_reader = fn(filePath) ->
      {:ok, partialData} = File.read(filePath)
      partialData
    end

    data = EbookGenerator.file_paths
           |> Enum.map(file_reader)
           |> Enum.join("\n\n \\pagebreak \n\n")
           |> String.replace("../images/", "./contents/images/")

    data = Enum.join([header_footer_data, data], "\n\n")
    File.write!("#{Book.main_path}/book-combined.md", data)
  end

  def file_paths do
    Book.contents
    |> Enum.map(fn(section) ->
      Enum.map(section.chapters, fn(chapter) ->
        "#{Book.main_path}/contents/#{section.ord}- #{section.title}/#{chapter.ord}- #{chapter.title}.md"
      end)
    end)
    |> List.flatten
  end

  def generate_pdf do
    # The following doesn't seem to work, but it runs fine from the shell:
    System.cmd("pandoc book-combined.md -o 'The Phoenix Tutorial.pdf' --latex-engine=/Library/TeX/texbin/xelatex", [])
  end

  def generate do
    generate_markdown()
    generate_pdf()
  end
end
