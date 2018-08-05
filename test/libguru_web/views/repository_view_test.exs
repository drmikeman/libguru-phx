defmodule LibguruWeb.RepositoryViewTest do
  use LibguruWeb.ConnCase, async: true

  alias LibguruWeb.{Repository, Repo}

  def repositories
    Repo.all(Repository)
  end
end
