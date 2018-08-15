defmodule Libguru.Service do
  def sth do
    Application.fetch_env!(:libguru, :github_token)
  end
end
