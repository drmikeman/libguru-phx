defmodule LibguruWeb.RepositoryController do
  use LibguruWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
