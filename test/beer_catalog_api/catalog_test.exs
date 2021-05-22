defmodule BeerCatalogApi.CatalogTest do
  use BeerCatalogApi.DataCase

  alias BeerCatalogApi.Catalog

  describe "beers" do
    alias BeerCatalogApi.Catalog.Beer

    @valid_attrs %{brand: "some brand", origin: "some origin", quantity: 42, style: "some style"}
    @update_attrs %{brand: "some updated brand", origin: "some updated origin", quantity: 43, style: "some updated style"}
    @invalid_attrs %{brand: nil, origin: nil, quantity: nil, style: nil}

    def beer_fixture(attrs \\ %{}) do
      {:ok, beer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_beer()

      beer
    end

    test "list_beers/0 returns all beers" do
      beer = beer_fixture()
      assert Catalog.list_beers() == [beer]
    end

    test "get_beer!/1 returns the beer with given id" do
      beer = beer_fixture()
      assert Catalog.get_beer!(beer.id) == beer
    end

    test "create_beer/1 with valid data creates a beer" do
      assert {:ok, %Beer{} = beer} = Catalog.create_beer(@valid_attrs)
      assert beer.brand == "some brand"
      assert beer.origin == "some origin"
      assert beer.quantity == 42
      assert beer.style == "some style"
    end

    test "create_beer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_beer(@invalid_attrs)
    end

    test "update_beer/2 with valid data updates the beer" do
      beer = beer_fixture()
      assert {:ok, %Beer{} = beer} = Catalog.update_beer(beer, @update_attrs)
      assert beer.brand == "some updated brand"
      assert beer.origin == "some updated origin"
      assert beer.quantity == 43
      assert beer.style == "some updated style"
    end

    test "update_beer/2 with invalid data returns error changeset" do
      beer = beer_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_beer(beer, @invalid_attrs)
      assert beer == Catalog.get_beer!(beer.id)
    end

    test "delete_beer/1 deletes the beer" do
      beer = beer_fixture()
      assert {:ok, %Beer{}} = Catalog.delete_beer(beer)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_beer!(beer.id) end
    end

    test "change_beer/1 returns a beer changeset" do
      beer = beer_fixture()
      assert %Ecto.Changeset{} = Catalog.change_beer(beer)
    end
  end

  describe "beers" do
    alias BeerCatalogApi.Catalog.Beer

    @valid_attrs %{-: "some -", brand: "some brand", "no-context": "some no-context", "no-schema": "some no-schema", origin: "some origin", quantity: 42, style: "some style"}
    @update_attrs %{-: "some updated -", brand: "some updated brand", "no-context": "some updated no-context", "no-schema": "some updated no-schema", origin: "some updated origin", quantity: 43, style: "some updated style"}
    @invalid_attrs %{-: nil, brand: nil, "no-context": nil, "no-schema": nil, origin: nil, quantity: nil, style: nil}

    def beer_fixture(attrs \\ %{}) do
      {:ok, beer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_beer()

      beer
    end

    test "list_beers/0 returns all beers" do
      beer = beer_fixture()
      assert Catalog.list_beers() == [beer]
    end

    test "get_beer!/1 returns the beer with given id" do
      beer = beer_fixture()
      assert Catalog.get_beer!(beer.id) == beer
    end

    test "create_beer/1 with valid data creates a beer" do
      assert {:ok, %Beer{} = beer} = Catalog.create_beer(@valid_attrs)
      assert beer.- == "some -"
      assert beer.brand == "some brand"
      assert beer.no-context == "some no-context"
      assert beer.no-schema == "some no-schema"
      assert beer.origin == "some origin"
      assert beer.quantity == 42
      assert beer.style == "some style"
    end

    test "create_beer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_beer(@invalid_attrs)
    end

    test "update_beer/2 with valid data updates the beer" do
      beer = beer_fixture()
      assert {:ok, %Beer{} = beer} = Catalog.update_beer(beer, @update_attrs)
      assert beer.- == "some updated -"
      assert beer.brand == "some updated brand"
      assert beer.no-context == "some updated no-context"
      assert beer.no-schema == "some updated no-schema"
      assert beer.origin == "some updated origin"
      assert beer.quantity == 43
      assert beer.style == "some updated style"
    end

    test "update_beer/2 with invalid data returns error changeset" do
      beer = beer_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_beer(beer, @invalid_attrs)
      assert beer == Catalog.get_beer!(beer.id)
    end

    test "delete_beer/1 deletes the beer" do
      beer = beer_fixture()
      assert {:ok, %Beer{}} = Catalog.delete_beer(beer)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_beer!(beer.id) end
    end

    test "change_beer/1 returns a beer changeset" do
      beer = beer_fixture()
      assert %Ecto.Changeset{} = Catalog.change_beer(beer)
    end
  end
end
