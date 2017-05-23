defmodule TutorialSite.Web.PageController do
  use TutorialSite.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def read_book(conn, _params) do
    render conn, "read_book.html", book: Book.contents
  end

  def read_chapter(conn, %{"section" => section, "chapter" => chapter}) do
    render conn, "read_chapter.html", section: section, chapter: chapter
  end
end
