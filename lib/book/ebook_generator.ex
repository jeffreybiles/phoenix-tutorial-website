defmodule EbookGenerator do
  def generate_markdown do
    {:ok, header_footer_data} = File.read("header_footer.md")
    file_reader = fn(filePath) ->
      {:ok, partialData} = File.read(filePath)
      partialData
    end

    data = EbookGenerator.file_paths
           |> Enum.map(file_reader)
           |> Enum.join("\n\n \\pagebreak \n\n")
           |> String.replace("../images/", "./contents/images/")

    data = Enum.join([header_footer_data, data], "\n\n")
    File.write!("book-combined.md", data)
  end

  def file_paths do
    Book.contents
    |> Enum.map(fn(section) ->
      Enum.map(section.chapters, fn(chapter) ->
        "contents/#{section.ord}- #{section.title}/#{chapter.ord}- #{chapter.title}.md"
      end)
    end)
    |> List.flatten
  end

  def generate_pdf do
    # The following doesn't seem to work here, but it runs fine from the shell:
    System.cmd("pandoc", ["book-combined.md",
                          "-o The Phoenix Tutorial.pdf",
                          "-V links-as-notes=true",
                          "--pdf-engine=/Library/TeX/texbin/xelatex",
                          "--highlight-style=tango",
                          "-V geometry:margin=1in"])
  end

  def generate do
    File.cd("lib/book")
    generate_markdown()
    generate_pdf()
    File.cd("../..")
  end
end
