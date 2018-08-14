defmodule Libguru.Dependency do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dependencies" do
    belongs_to :library, Libguru.Library
    belongs_to :repository, Libguru.Repository
    timestamps()
  end

  @doc false
  def changeset(dependency, attrs) do
    dependency
    |> cast(attrs, [:library_id, :repository_id])
    |> validate_required([:library_id, :repository_id])
  end
end
