defmodule Libguru.FetchService do
  require Ecto.Query

  def process do
    fetch_repositories()
    |> Enum.each(&process_repository/1)
  end

  def fetch_repositories do
    {200, data, _response} = Tentacat.Repositories.list_mine(client(), type: "owner")
    data |> Enum.map(&fetch_repository_data/1)
  end

  def process_repository(repository_data) do
    repository_data
    |> persist_repository
    |> fetch_gemfile
    |> process_gemfile
    |> persist_libraries(repository_data)
  end

  def persist_repository(%{"name" => name, "html_url" => url, "description" => description}) do
    (Libguru.Repository |> Ecto.Query.where(name: ^name, url: ^url) |> Libguru.Repo.one) || Libguru.Repo.insert!(
      %Libguru.Repository{
        name: name,
        url: url,
        description: description
      }
    )
  end

  def persist_libraries({:error}, _) do
    {:error}
  end

  def persist_libraries(names, %{"name" => name, "html_url" => url}) do
    names |> Enum.each(&persist_library(&1, name, url))
  end

  def persist_library(library_name, repository_name, repository_url) do
    library = (Libguru.Library |> Ecto.Query.where(name: ^library_name) |> Libguru.Repo.one) || Libguru.Repo.insert!(
      %Libguru.Library{name: library_name, url: "http://github.com"}
    )
    repository = Libguru.Repository |> Ecto.Query.where(name: ^repository_name, url: ^repository_url) |> Libguru.Repo.one
    Libguru.Library.add_repository_to_library(repository, library)
  end

  def fetch_gemfile(repository) do
    case Tentacat.Contents.find(client(), "drmikeman", repository.name, "Gemfile.lock") do
      {200, data, _response} ->
        data |> Map.get("content") |> Base.decode64(ignore: :whitespace)
      _ ->  {:error}
    end
  end

  def process_gemfile({:error}) do
    {:error}
  end

  def process_gemfile({:ok, gemfile}) do
    [_, deps] = Regex.run(~r/DEPENDENCIES\n(?<deps>.*)(?=\n\nRUBY)/s, gemfile)
    Regex.scan(~r/\s*([\w\d-]+)\s/, deps) |> Enum.map(&(Enum.at(&1, 1)))
  end

  defp client do
    token = Application.fetch_env!(:libguru, :github_token)
    Tentacat.Client.new(%{access_token: token})
  end

  defp fetch_repository_data(data) do
    Map.take(data, ["name", "url", "html_url", "description"])
  end
end
