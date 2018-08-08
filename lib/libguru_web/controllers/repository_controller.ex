defmodule LibguruWeb.RepositoryController do
  use LibguruWeb, :controller

  alias Libguru.{Repository, Repo}

  def index(conn, _params) do
    render(conn, "index.html", repositories: Repo.all(Repository))
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Repository, id) do
      nil ->
        conn
        |> put_flash(:error, "Repository not found")
        |> redirect(to: repository_path(conn, :index))

      repository ->
        render(conn, "show.html", repository: repository)
    end
  end
end
