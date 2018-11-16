defmodule Libguru.Fixtures do
  @gemfile """
    PLATFORMS
      ruby

    DEPENDENCIES
      aasm (~> 3.0.22)
      actionpack (~> 1.2.0)

    BUNDLED WITH
      1.16.5
  """

  def gemfile do
    @gemfile
  end
end
