defmodule ShopApp.Accounts.User do
  use ShopApp.Schema

  schema "users" do
    field(:username, :string)
    field(:email, :string)
  end

  def changeset(user, attrs) do
    required_fields = [:username, :email]

    user
    |> cast(attrs, required_fields)
  end
end

# changesets

# user = %{username: "rich", email: "richjmatt26@gmail.com"}
# changeset = User.changeset(%User{}, user)
# Repo.insert(changeset)
# Repo.all(User)

# migrations

# mix ecto.gen.migration create_products_table
