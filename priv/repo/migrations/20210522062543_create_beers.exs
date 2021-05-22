defmodule BeerCatalogApi.Repo.Migrations.CreateBeers do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :brand, :string
      add :style, :string
      add :origin, :string
      add :quantity, :integer

      timestamps()
    end

  end
end
