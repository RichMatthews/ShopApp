defmodule ShopApp.Accounts do
  alias ShopApp.Accounts.User
  alias ShopApp.{Repo}
  import Ecto.Query, warn: false

  def get_user(id) do
    Repo.get!(User, id)
  end

  def list_users do
    Repo.all(User)
  end
end
