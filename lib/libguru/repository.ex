defmodule Libguru.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :name, :string
    field :description, :string
    field :url, :string
    many_to_many :libraries, Libguru.Library, join_through: Libguru.Dependency
    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :description, :url])
    |> validate_required([:name, :url])
  end
end
