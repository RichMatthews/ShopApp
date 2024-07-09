defmodule ShopApp.Repo.Migrations.CreateOrderItemsTable do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:product_id, :uuid, null: false)
      add(:quantity, :integer)
      add(:price, :decimal)
      add(:discount, :decimal)
      add(:name, :string)
      add(:order_id, :uuid, null: false)

      timestamps()
    end
  end
end
