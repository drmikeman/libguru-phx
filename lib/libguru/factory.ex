defmodule Libguru.Factory do
  use ExMachina.Ecto, repo: Libguru.Repo

  def library_factory do
    %Libguru.Library{
      name: Faker.Company.buzzword_suffix(),
      info: Faker.Lorem.sentence(7),
      url: "http://github.com"
    }
  end

  def repository_factory do
    %Libguru.Repository{
      name: Faker.Team.name,
      description: Faker.Lorem.sentence(7),
      url: "http://github.com"
    }
  end
end
