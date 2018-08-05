defmodule LibguruWeb.RepositoryControllerTest do
  use LibguruWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Libraries"
  end
end
