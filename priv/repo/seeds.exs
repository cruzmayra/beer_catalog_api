# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BeerCatalogApi.Repo.insert!(%BeerCatalogApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

BeerCatalogApi.Repo.insert!(%BeerCatalogApi.Catalog.Beer{
  brand: "Milwaukee's Best Light",
  style: "American-Style Light Lager",
  origin: "USA",
  quantity: 1200
})
BeerCatalogApi.Repo.insert!(%BeerCatalogApi.Catalog.Beer{
  brand: "Dos Equis",
  style: "Lager Especial",
  origin: "Mexico",
  quantity: 430
})
BeerCatalogApi.Repo.insert!(%BeerCatalogApi.Catalog.Beer{
  brand: "Maibock",
  style: "Bavarian lager",
  origin: "Germany",
  quantity: 4000
})
