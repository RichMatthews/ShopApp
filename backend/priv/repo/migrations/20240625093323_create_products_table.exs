defmodule ShopApp.Repo.Migrations.CreateProductsTable do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string, null: false)
      add(:description, :string)
      add(:price, :decimal)
      add(:stock, :integer)

      timestamps()
    end
  end
end
