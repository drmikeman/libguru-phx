defmodule Libguru.LibraryTest do
  use Libguru.DataCase

  import Libguru.Factory

  alias Libguru.Library

  @valid_attrs %{name: "devise", info: "Devise gem", url: "http://github.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Library.changeset(%Library{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Library.changeset(%Library{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "updates the repository count cache" do
    library = insert(:library)
    Library.add_repository_to_library(insert(:repository), library)
    Library.add_repository_to_library(insert(:repository), library)
    library = Libguru.Repo.get(Library, library.id)

    assert library.repository_count == 2
  end
end
