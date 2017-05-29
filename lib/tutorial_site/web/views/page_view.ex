defmodule TutorialSite.Web.PageView do
  use TutorialSite.Web, :view


  def hyphenate(str) do
    String.replace(str, " ", "-")
  end

  def unhyphenate(str) do
    String.replace(str, "-", " ")
  end

  def content(chapter_title) do
    raw Book.get_html(unhyphenate(chapter_title))
  end

  def next(chapter_title) do
    chapter = Book.next(unhyphenate(chapter_title))
    "/read/#{chapter.section_title}/#{chapter.chapter_title}"
  end

  def previous(chapter_title) do
    chapter = Book.previous(unhyphenate(chapter_title))
    "/read/#{chapter.section_title}/#{chapter.chapter_title}"
  end
end
