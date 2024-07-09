defmodule ShopApp.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:user_id, :uuid, null: false)
      add(:total, :decimal, null: false)

      timestamps()
    end
  end
end
