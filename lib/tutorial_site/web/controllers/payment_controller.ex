defmodule TutorialSite.Web.PaymentController do
  use TutorialSite.Web, :controller

  def ebook(conn, _params) do
    render conn, "ebook.html", page_title: "Ebook for The Phoenix Tutorial", phoenix_testimonials: Testimonials.phoenix
  end

  def videos(conn, _params) do
    render conn, "videos.html", page_title: "Screencasts for The Phoenix Tutorial- Coming Soon!"
  end
end
