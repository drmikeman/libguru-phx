defmodule LibguruWeb.LibraryController do
  use LibguruWeb, :controller

  alias Libguru.{Library, Repo}

  require Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html", libraries: Repo.all(Library))
  end

  def show(conn, %{"id" => id}) do
    Library
    |> Repo.get(id)
    |> Repo.preload(:repositories)
    |> case do
      nil ->
        conn
        |> put_flash(:error, "Library not found")
        |> redirect(to: library_path(conn, :index))

      library ->
        render(conn, "show.html", library: library, repositories: library.repositories)
    end
  end

  def ranking(conn, _params) do
    render(conn, "ranking.html", libraries: Library |> Ecto.Query.order_by(desc: :repository_count) |> Repo.all )
  end
end
