defmodule LibguruWeb.RepositoryControllerTest do
  use LibguruWeb.ConnCase
  import Libguru.Factory

  test "index/2 responds with all repositories", %{conn: conn} do
    repositories = insert_pair(:repository)

    conn = get(conn, repository_path(conn, :index))

    for repository <- repositories do
      assert html_response(conn, 200) =~ repository.name
    end
  end

  describe "show/2" do
    test "responds with repository info if the repository found", %{conn: conn} do
      repository = insert(:repository)

      conn = get(conn, repository_path(conn, :show, repository.id))

      assert html_response(conn, 200) =~ repository.name
    end

    test "responds with a message indicating repository not found", %{conn: conn} do
      conn = get(conn, repository_path(conn, :show, 5))

      assert redirected_to(conn, 302) =~ repository_path(conn, :index)
      assert get_flash(conn, :error) =~ "Repository not found"
    end

    test "responds with a list of libraries", %{conn: conn} do
      repository = insert(:repository) |> with_libraries |> Libguru.Repo.preload(:libraries)
      library = repository.libraries |> List.first

      conn = get(conn, repository_path(conn, :show, repository.id))

      assert html_response(conn, 200) =~ library.name
    end
  end
end
