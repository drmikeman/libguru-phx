defmodule LibguruWeb.RepositoryController do
  use LibguruWeb, :controller

  alias Libguru.{Repository, Repo}

  def index(conn, _params) do
    render(conn, "index.html", repositories: Repo.all(Repository))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", repository: Repo.get(Repository, id))
  end
end
