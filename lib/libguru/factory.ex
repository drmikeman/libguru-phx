defmodule Libguru.Factory do
  use ExMachina.Ecto, repo: Libguru.Repo

  def repository_factory do
    %Libguru.Repository{
      name: sequence(:name, &"repository#{&1}"),
      description: "Repository description",
      url: "http://github.com"
    }
  end
end
