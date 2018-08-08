defmodule Libguru.RepositoryTest do
  use Libguru.DataCase

  alias Libguru.Repository

  @valid_attrs %{name: "libguru", description: "Libguru project", url: "http://github.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Repository.changeset(%Repository{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Repository.changeset(%Repository{}, @invalid_attrs)
    refute changeset.valid?
  end
end
