defmodule ShopApp.Resolvers.Commerce do
  alias ShopApp.Commerce

  def product(_, %{id: id}, _) do
    {:ok, Commerce.get_product(id)}
  end

  def products(_, args, _) do
    {:ok, Commerce.list_products(args)}
  end

  # def reviews(%{id: id}, _, _) do
  #   {:ok, Commerce.get_product_reviews(id)}
  # end

  def create_review(_, _args, _) do
    {:ok, Commerce}
  end

  def create_order(_, _args, _) do
    {:ok, Commerce.create_order()}
  end

  def create_product(_, args, _) do
    IO.inspect(args, label: "Args before!!")
    Commerce.create_product(args)
  end

  def orders(_, %{user_id: user_id}, _) do
    {:ok, Commerce.get_orders_by_user_id(user_id)}
  end
end
