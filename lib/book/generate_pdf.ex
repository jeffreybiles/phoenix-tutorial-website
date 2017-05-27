folderPaths = ["0- Intro", "1- Elixir Crash Course"]#, "part-2-first-phoenix-page", "part-3-generated-materials"]

[introFilepaths, part1Filepaths] = Enum.map(folderPaths, fn(folderPath) ->
  {:ok, fileNames} = File.ls("contents/#{folderPath}")
  Enum.map(fileNames, fn(fileName) -> "#{folderPath}/#{fileName}" end)
end)
{:ok, header_footer_data} = File.read("header_footer.md")

file_reader = fn(partialFileName) ->
  {:ok, partialData} = File.read("contents/#{partialFileName}")
  partialData
end

# TODO: Make this generate off of book.ex

data = (introFilepaths ++ part1Filepaths)
       |> Enum.map(file_reader)
       |> Enum.join("\n\n \\pagebreak \n\n")
       |> String.replace("../images/", "./contents/images/")

data = Enum.join([header_footer_data, data], "\n\n")
File.write!("book-combined.md", data)

# The following doesn't seem to work, but it runs fine from the shell:
System.cmd("pandoc book-combined.md -o 'The Phoenix Tutorial.pdf' --latex-engine=/Library/TeX/texbin/xelatex", [])
