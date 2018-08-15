defmodule Libguru.Library do
  use Ecto.Schema
  import Ecto.Changeset

  schema "libraries" do
    field :name, :string
    field :info, :string
    field :url, :string
    field :repository_count, :integer, default: 0
    many_to_many :repositories, Libguru.Repository, join_through: Libguru.Dependency
    timestamps()
  end

  @doc false
  def changeset(library, attrs) do
    library
    |> cast(attrs, [:name, :info, :url])
    |> validate_required([:name, :url])
  end

  def add_repository_to_library(%Libguru.Repository{} = repository, %Libguru.Library{} = library) do
    Libguru.Dependency.changeset(%Libguru.Dependency{}, %{library_id: library.id, repository_id: repository.id})
    |> increment_counter_cache(library, :repository_count)
    |> Libguru.Repo.insert
  end

  defp increment_counter_cache(changeset, struct, counter_name, value \\ 1) do
    prepare_changes(changeset, fn prepared_changeset ->
      Libguru.Repo.increment(struct, counter_name, value)
      prepared_changeset
    end)
  end
end
