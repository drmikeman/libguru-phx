defmodule LibguruWeb.RepositoryController do
  use LibguruWeb, :controller

  alias Libguru.{Repository, Repo}

  def index(conn, _params) do
    render(conn, "index.html", repositories: Repo.all(Repository))
  end

  def show(conn, %{"id" => id}) do
    Repository
    |> Repo.get(id)
    |> Repo.preload(:libraries)
    |> case do
      nil ->
        conn
        |> put_flash(:error, "Repository not found")
        |> redirect(to: repository_path(conn, :index))

      repository ->
        render(conn, "show.html", repository: repository, libraries: repository.libraries)
    end
  end
end
