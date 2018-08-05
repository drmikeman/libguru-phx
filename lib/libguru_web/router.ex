defmodule LibguruWeb.Router do
  use LibguruWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LibguruWeb do
    pipe_through :browser # Use the default browser stack

    get "/", RepositoryController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LibguruWeb do
  #   pipe_through :api
  # end
end
