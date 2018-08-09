defmodule LibguruWeb.LibraryController do
  use LibguruWeb, :controller

  alias Libguru.{Library, Repo}

  def index(conn, _params) do
    render(conn, "index.html", libraries: Repo.all(Library))
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Library, id) do
      nil ->
        conn
        |> put_flash(:error, "Library not found")
        |> redirect(to: library_path(conn, :index))

      library ->
        render(conn, "show.html", library: library)
    end
  end
end
