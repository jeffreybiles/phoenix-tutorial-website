defmodule TutorialSiteWeb.PageController do
  use TutorialSiteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", ember_testimonials: Testimonials.ember, phoenix_testimonials: Testimonials.phoenix
  end

  def read_book(conn, _params) do
    render conn, "read_book.html", book: Book.contents, page_title: "Read The Phoenix Tutorial online for free"
  end

  def read_chapter(conn, %{"section" => section, "chapter" => chapter}) do
    readable_chapter = "#{chapter} (#{section}, The Phoenix Tutorial)" |> String.split("-") |> Enum.join(" ")
    render conn, "read_chapter.html", section: section, chapter: chapter,
                  book: Book.contents, page_title: readable_chapter
  end

  def buy_ebook(conn, _params) do
    render conn, "buy_ebook.html", page_title: "Ebook for The Phoenix Tutorial- Coming Soon!", phoenix_testimonials: Testimonials.phoenix
  end

  def buy_videos(conn, _params) do
    render conn, "buy_videos.html", page_title: "Screencasts for The Phoenix Tutorial- Coming Soon!"
  end

  def mailing_list(conn, _params) do
    render conn, "mailing_list.html", page_title: "Mailing List signup for The Phoenix Tutorial"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
end
