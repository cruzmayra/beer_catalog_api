defmodule BeerCatalogApiWeb.BeerView do
  use BeerCatalogApiWeb, :view
  alias BeerCatalogApiWeb.BeerView

  def render("index.json", %{beers: beers}) do
    %{data: render_many(beers, BeerView, "beer.json")}
  end

  def render("show.json", %{beer: beer}) do
    %{data: render_one(beer, BeerView, "beer.json")}
  end

  def render("beer.json", %{beer: beer}) do
    %{id: beer.id,
      brand: beer.brand,
      style: beer.style,
      origin: beer.origin,
      quantity: beer.quantity}
  end
end
