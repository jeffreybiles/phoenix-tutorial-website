defmodule TutorialSiteWeb.PageView do
  use TutorialSiteWeb, :view


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
    if chapter do
      "<a href='/read/#{chapter.section_title}/#{chapter.chapter_title}'>#{chapter.chapter_title} >></a>"
    else
      "<a href='/mailing_list'>Get notified about updates</a>"
    end
  end

  def previous(chapter_title) do
    chapter = Book.previous(unhyphenate(chapter_title))
    if chapter do
      "<a href='/read/#{chapter.section_title}/#{chapter.chapter_title}'><< #{chapter.chapter_title}</a>"
    else
      ""
    end
  end
end
