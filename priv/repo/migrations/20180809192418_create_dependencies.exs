defmodule Libguru.Repo.Migrations.CreateDependencies do
  use Ecto.Migration

  def change do
    create table(:dependencies, primary_key: false) do
      add :library_id, references(:libraries, on_delete: :nothing)
      add :repository_id, references(:repositories, on_delete: :nothing)

      timestamps()
    end

    create index(:dependencies, [:library_id])
    create index(:dependencies, [:repository_id])
  end
end
