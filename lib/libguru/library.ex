defmodule Libguru.Library do
  use Ecto.Schema
  import Ecto.Changeset

  schema "libraries" do
    field :name, :string
    field :info, :string
    field :url, :string
    many_to_many :repositories, Libguru.Repository, join_through: Libguru.Dependency
    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :info, :url])
    |> validate_required([:name, :url])
  end
end
