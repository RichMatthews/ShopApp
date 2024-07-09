defmodule ShopApp.Commerce do
  alias ShopApp.Repo
  alias ShopApp.Commerce.{Order, Product}

  @moduledoc """
  The Commerce context: public interface for finding,
  and reviewing products.
  """

  import Ecto.Query, warn: false

  def get_product(id) do
    Repo.get!(Product, id)
  end

  def list_products do
    Repo.all(Product)
  end

  def list_products(criteria) do
    query = from(p in Product)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from(p in query, limit: ^limit)
    end)
    |> Repo.all()
  end

  def get_orders_by_user_id(id) do
    query = from(o in Order, where: o.user_id == ^id)
    Repo.all(query)
  end

  # def get_product_reviews(id) do
  #   query = from(r in Review, where: r.product_id == ^id)
  #   Repo.all(query)
  # end
  def create_review(_id) do
    %{}
  end

  def create_product(args) do
    %Product{}
    |> Product.changeset(args)
    |> Repo.insert()
  end
end
