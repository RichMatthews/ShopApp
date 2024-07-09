defmodule ShopApp.Commerce.Order do
  use ShopApp.Schema

  alias ShopApp.Commerce.OrderItem

  schema "orders" do
    field(:user_id, :binary_id)
    field(:total, :decimal)

    has_many(:order_items, OrderItem)
    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_id, :total])
    |> cast_assoc(:order_items)
  end
end
