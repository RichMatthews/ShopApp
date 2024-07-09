defmodule ShopApp.Commerce.OrderItem do
  alias ShopApp.Commerce.Order
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field(:product_id, :binary_id)
    field(:quantity, :integer)
    field(:price, :decimal)
    field(:discount, :decimal)
    field(:name, :string)

    belongs_to(:order, Order)

    timestamps()
  end

  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:product_id, :quantity, :price, :discount, :name])
  end
end
