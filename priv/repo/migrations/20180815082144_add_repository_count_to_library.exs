defmodule Libguru.Repo.Migrations.AddRepositoryCountToLibrary do
  use Ecto.Migration

  def change do
    alter table(:libraries) do
      add :repository_count, :integer, default: 0
    end
  end
end
