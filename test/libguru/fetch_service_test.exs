defmodule TentacatMock do
  defmodule Repositories do
    def list_mine(_, type: "owner") do
      {
        200,
        [
          %{"name" => "Repo1", "url" => "url1", "html_url" => "html_url1", "description" => "desc1" },
          %{"name" => "Repo2", "url" => "url2", "html_url" => "html_url2", "description" => "desc2" }
        ],
        nil
      }
    end
  end

  defmodule Contents do
    import Libguru.Fixtures

    def find(_client, _username, "repo", "Gemfile.lock") do
      {:error}
    end

    def find(_client, _username, _repository_name, "Gemfile.lock") do
      data = %{"content" => Base.encode64(gemfile())}
      {200, data, nil}
    end
  end
end

defmodule Libguru.FetchServiceTest do
  use ExUnit.Case
  use LibguruWeb.ConnCase
  import Libguru.Factory
  import Ecto.Query
  alias Libguru.FetchService

  describe "Libguru.FetchService.process_repository" do
    test "" do
      repository_data = %{"name" => "Repo", "url" => "url", "html_url" => "html_url", "description" => "desc" }
      repository_count = count_repository
      library_count = count_library

      FetchService.process_repository(repository_data)

      assert count_repository == repository_count + 1
      assert count_library == library_count + 2

      repository = Libguru.Repository |> Ecto.Query.last |> Libguru.Repo.one
      assert repository.name == "Repo"
      repository = repository |> Libguru.Repo.preload(:libraries)
      assert length(repository.libraries) == 2
    end
  end

  describe "Libguru.FetchService.persist_repository" do
    test "adds a new repository" do
      count = count_repository()
      FetchService.persist_repository(%{"name" => "Repo", "html_url" => "html_url", "description" => "desc" })
      assert count_repository() == count + 1
    end

    test "modifies the existing repository" do
      insert(:repository, name: "Repo", url: "html_url", description: "desc")
      count = count_repository()
      FetchService.persist_repository(%{"name" => "Repo", "html_url" => "html_url", "description" => "new desc" })
      assert count_repository() == count
    end
  end

  describe "Libguru.FetchService.persist_libraries" do
    test "return error when error" do
      assert FetchService.persist_libraries({:error}, nil) == {:error}
    end
  end

  describe "Libguru.FetchService.persist_library" do
    test "adds a new library" do
      insert(:repository, name: "Repo", url: "html_url", description: "desc")
      count = count_library()
      FetchService.persist_library("Library", "Repo", "html_url")
      assert count_library() == count + 1
    end

    test "modifies the existing library" do
      insert(:repository, name: "Repo", url: "html_url", description: "desc")
      insert(:library, name: "Library")
      count = count_library()
      FetchService.persist_library("Library", "Repo", "html_url")
      assert count_library() == count
    end
  end

  describe "Libguru.FetchService.fetch_gemfile" do
    import Libguru.Fixtures

    test "fetches the content of the repository's gemfile" do
      repository = build(:repository)
      assert FetchService.fetch_gemfile(repository) == {:ok, gemfile()}
    end

    test "returns error when error" do
      repository = build(:repository, name: "repo")
      assert FetchService.fetch_gemfile(repository) == {:error}
    end
  end

  describe "Libguru.FetchService.process_gemfile" do
    import Libguru.Fixtures

    test "extracts names of libraries from the gemfile" do
      assert FetchService.process_gemfile({:ok, gemfile()}) == ["aasm", "actionpack"]
    end

    test "returns error when error" do
      assert FetchService.process_gemfile({:error}) == {:error}
    end
  end

  def count_library do
    Libguru.Library
    |> select([p], count(p.id))
    |> Libguru.Repo.one
  end

  def count_repository do
    Libguru.Repository
    |> select([p], count(p.id))
    |> Libguru.Repo.one
  end
end
