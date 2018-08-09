defmodule Libguru.LibraryTest do
  use Libguru.DataCase

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
end
