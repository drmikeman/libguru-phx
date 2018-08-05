defmodule Libguru.Repository do
  use Ecto.Schema
  import Ecto.Changeset


  schema "repositories" do
    field :description, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :description, :url])
    |> validate_required([:name, :url])
  end
end