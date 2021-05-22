defmodule BeerCatalogApiWeb.BeerControllerTest do
  use BeerCatalogApiWeb.ConnCase

  alias BeerCatalogApi.Catalog
  alias BeerCatalogApi.Catalog.Beer

  @create_attrs %{
    -: "some -",
    brand: "some brand",
    no-context: "some no-context",
    no-schema: "some no-schema",
    origin: "some origin",
    quantity: 42,
    style: "some style"
  }
  @update_attrs %{
    -: "some updated -",
    brand: "some updated brand",
    no-context: "some updated no-context",
    no-schema: "some updated no-schema",
    origin: "some updated origin",
    quantity: 43,
    style: "some updated style"
  }
  @invalid_attrs %{-: nil, brand: nil, "no-context": nil, "no-schema": nil, origin: nil, quantity: nil, style: nil}

  def fixture(:beer) do
    {:ok, beer} = Catalog.create_beer(@create_attrs)
    beer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all beers", %{conn: conn} do
      conn = get(conn, Routes.beer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create beer" do
    test "renders beer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.beer_path(conn, :create), beer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.beer_path(conn, :show, id))

      assert %{
               "id" => id,
               "-" => "some -",
               "brand" => "some brand",
               "no-context" => "some no-context",
               "no-schema" => "some no-schema",
               "origin" => "some origin",
               "quantity" => 42,
               "style" => "some style"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.beer_path(conn, :create), beer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update beer" do
    setup [:create_beer]

    test "renders beer when data is valid", %{conn: conn, beer: %Beer{id: id} = beer} do
      conn = put(conn, Routes.beer_path(conn, :update, beer), beer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.beer_path(conn, :show, id))

      assert %{
               "id" => id,
               "-" => "some updated -",
               "brand" => "some updated brand",
               "no-context" => "some updated no-context",
               "no-schema" => "some updated no-schema",
               "origin" => "some updated origin",
               "quantity" => 43,
               "style" => "some updated style"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, beer: beer} do
      conn = put(conn, Routes.beer_path(conn, :update, beer), beer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete beer" do
    setup [:create_beer]

    test "deletes chosen beer", %{conn: conn, beer: beer} do
      conn = delete(conn, Routes.beer_path(conn, :delete, beer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.beer_path(conn, :show, beer))
      end
    end
  end

  defp create_beer(_) do
    beer = fixture(:beer)
    %{beer: beer}
  end
end
