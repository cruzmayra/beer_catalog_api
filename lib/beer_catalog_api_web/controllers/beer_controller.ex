defmodule BeerCatalogApiWeb.BeerController do
  use BeerCatalogApiWeb, :controller
  use PhoenixSwagger

  alias BeerCatalogApi.Catalog
  alias BeerCatalogApi.Catalog.Beer

  action_fallback BeerCatalogApiWeb.FallbackController

  swagger_path :index do
    get "/api/beers"
    summary "List of beers"
    description "List all beers in the database"
    tag "Beers"
    produces "application/json"
    response 200, "OK", Schema.ref(:BeersResponse),
    example: %{
      data: [
        %{
          brand: "Milwaukee's Best Light",
          id: 1,
          origin: "USA",
          quantity: 1200,
          style: "American-Style Light Lager"
        }
      ]
    }
    response 500, "Internal Server Error"
  end

  def index(conn, _params) do
    beers = Catalog.list_beers()
    render(conn, "index.json", beers: beers)
  end

  swagger_path :create do
    post "/api/beers"
    summary "Create a new beer register"
    description "Create a new beer register"
    tag "Beers"
    parameters do
      brand :body, :string, "Beer brand", required: true, example: "Cucapá Border"
      origin :body, :string, "Nation origin", required: true, example: "Mexico"
      quantity :body, :integer, "quantity beer", required: true, example: "200"
      style :body, :string, "beer style", required: true, example: "Amber Ale"
    end
    produces "application/json"
    response 201, "Create", Schema.ref(:BeersResponse)
    response 400, "Bad request for create register"
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
