defmodule ShopApp.Resolvers.Accounts do
  alias ShopApp.Accounts

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user(id)}
  end
end
