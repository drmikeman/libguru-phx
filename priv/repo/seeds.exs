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

Libguru.Repo.insert!(%Libguru.Repository{
  name: "hotelstonight",
  description: "HotelTonight",
  url: "https://github.com/hoteltonight/hotelstonight"
})

Libguru.Repo.insert!(%Libguru.Repository{
  name: "jaacoo",
  description: "Jaacoo",
  url: "https://github.com/netguru/jaacoo"
})

Libguru.Repo.insert!(%Libguru.Repository{
  name: "permissions",
  description: "Permissions",
  url: "https://github.com/netguru/permissions"
})
