defmodule BeerCatalogApi.Repo do
  use Ecto.Repo,
    otp_app: :beer_catalog_api,
    adapter: Ecto.Adapters.MyXQL
end
