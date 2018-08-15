# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Libguru.Repo.insert!(%Libguru.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Libguru.Factory

defmodule Libguru.Seeds do
  def insert_dependency(library_id, repository_id) do
    %Libguru.Dependency{
      library_id: library_id,
      repository_id: repository_id,
    } |> Libguru.Repo.insert!
  end
end

libraries = insert_list(3, :library)
repositories = insert_list(3, :repository)

Libguru.Library.add_repository_to_library(Enum.at(repositories, 0), Enum.at(libraries, 0))
Libguru.Library.add_repository_to_library(Enum.at(repositories, 1), Enum.at(libraries, 0))
Libguru.Library.add_repository_to_library(Enum.at(repositories, 2), Enum.at(libraries, 1))
