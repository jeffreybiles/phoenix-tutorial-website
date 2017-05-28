defmodule TutorialSite.Web.PageView do
  use TutorialSite.Web, :view


  def hyphenate(str) do
    String.replace(str, " ", "-")
  end

  def unhyphenate(str) do
    String.replace(str, "-", " ")
  end

  def content(section, chapter) do
    raw Book.get_html(unhyphenate(section), unhyphenate(chapter))
  end
end
