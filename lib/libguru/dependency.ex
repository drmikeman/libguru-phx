defmodule Libguru.Dependency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
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
    |> unique_constraint(:library_id, name: "libraries_repositories_library_id_repository_id_index")
  end
end
