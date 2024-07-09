defmodule ShopApp.Commerce.Product do
  use ShopApp.Schema

  alias ShopApp.Commerce.Review

  schema "products" do
    field(:name, :string)
    field(:description, :string)
    field(:price, :decimal)
    field(:stock, :integer)

    has_many(:reviews, Review)

    timestamps()
  end

  def changeset(product, attrs) do
    required_fields = [:name, :price, :id]
    optional_fields = [:description, :stock]

    product
    |> cast(attrs, required_fields ++ optional_fields)
  end
end
