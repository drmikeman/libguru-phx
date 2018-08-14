defmodule LibguruWeb.LibraryControllerTest do
  use LibguruWeb.ConnCase
  import Libguru.Factory

  test "index/2 responds with all libraries", %{conn: conn} do
    libraries = insert_pair(:library)

    conn = get(conn, library_path(conn, :index))

    for library <- libraries do
      assert html_response(conn, 200) =~ library.name
    end
  end

  describe "show/2" do
    test "responds with library info if the library found", %{conn: conn} do
      library = insert(:library)

      conn = get(conn, library_path(conn, :show, library.id))

      assert html_response(conn, 200) =~ library.name
    end

    test "responds with a message indicating library not found", %{conn: conn} do
      conn = get(conn, library_path(conn, :show, 5))

      assert redirected_to(conn, 302) =~ library_path(conn, :index)
      assert get_flash(conn, :error) =~ "Library not found"
    end

    test "responds with a list of repositories", %{conn: conn} do
      library = insert(:library) |> with_repositories |> Libguru.Repo.preload(:repositories)
      repository = library.repositories |> List.first

      conn = get(conn, library_path(conn, :show, library.id))

      assert html_response(conn, 200) =~ repository.name
    end
  end
end
