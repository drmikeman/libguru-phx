defmodule Libguru.DependencyTest do
  use Libguru.DataCase

  alias Libguru.Dependency

  @valid_attrs %{library_id: 1, repository_id: 2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dependency.changeset(%Dependency{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dependency.changeset(%Dependency{}, @invalid_attrs)
    refute changeset.valid?
  end
end
