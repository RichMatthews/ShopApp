defmodule ShopApp.Commerce.Review do
  use ShopApp.Schema

  schema "reviews" do
    field(:rating, :integer)
    field(:comment, :string)

    belongs_to(:product, ShopApp.Commerce.Product)
    belongs_to(:user, ShopApp.Accounts.User)

    timestamps(type: :utc_datetime)
  end

  def changeset(review, attrs) do
    required_fields = [:rating, :comment, :product_id, :user_id]

    review
    |> cast(attrs, required_fields)
    |> assoc_constraint(:product)
    |> assoc_constraint(:user)
  end
end
