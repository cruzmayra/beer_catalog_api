defmodule BeerCatalogApiWeb.BeerController do
  use BeerCatalogApiWeb, :controller
  use PhoenixSwagger

  alias BeerCatalogApi.Catalog
  alias BeerCatalogApi.Catalog.Beer

  action_fallback BeerCatalogApiWeb.FallbackController

  swagger_path :index do
    get("/api/beers")
    description("List of beers")
    response(:ok, "Success")
  end

  def index(conn, _params) do
    beers = Catalog.list_beers()
    render(conn, "index.json", beers: beers)
  end


  def create(conn, %{"beer" => beer_params}) do
    with {:ok, %Beer{} = beer} <- Catalog.create_beer(beer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.beer_path(conn, :show, beer))
      |> render("show.json", beer: beer)
    end
  end

  def show(conn, %{"id" => id}) do
    beer = Catalog.get_beer!(id)
    render(conn, "show.json", beer: beer)
  end

  def update(conn, %{"id" => id, "beer" => beer_params}) do
    beer = Catalog.get_beer!(id)

    with {:ok, %Beer{} = beer} <- Catalog.update_beer(beer, beer_params) do
      render(conn, "show.json", beer: beer)
    end
  end

  def delete(conn, %{"id" => id}) do
    beer = Catalog.get_beer!(id)

    with {:ok, %Beer{}} <- Catalog.delete_beer(beer) do
      send_resp(conn, :no_content, "")
    end
  end
end
