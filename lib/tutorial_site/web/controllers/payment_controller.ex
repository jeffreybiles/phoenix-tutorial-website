defmodule TutorialSite.Web.PaymentController do
  use TutorialSite.Web, :controller

  def buy_ebook(conn, _params) do
    render conn, "buy_ebook.html", page_title: "Ebook for The Phoenix Tutorial", phoenix_testimonials: Testimonials.phoenix
  end

  def buy_videos(conn, _params) do
    render conn, "buy_videos.html", page_title: "Screencasts for The Phoenix Tutorial- Coming Soon!"
  end
end
