defmodule BeerCatalogApi.Catalog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "beers" do
    field :brand, :string
    field :origin, :string
    field :quantity, :integer
    field :style, :string

    timestamps()
  end

  @doc false
  def changeset(catalog, attrs) do
    catalog
    |> cast(attrs, [:brand, :style, :origin, :quantity])
    |> validate_required([:brand, :style, :origin, :quantity])
  end
end
