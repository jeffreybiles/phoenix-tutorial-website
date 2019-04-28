defmodule TutorialSite.PageControllerTest do
  use TutorialSiteWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "The Phoenix Tutorial"
  end
end
