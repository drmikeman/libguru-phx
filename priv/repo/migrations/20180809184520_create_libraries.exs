defmodule Libguru.Repo.Migrations.CreateLibraries do
  use Ecto.Migration

  def change do
    create table(:libraries) do
      add :name, :string
      add :info, :string
      add :url, :string

      timestamps()
    end

  end
end
