defmodule ShopApp.Schema.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias ShopApp.Resolvers
  alias ShopApp.Commerce.OrderItem

  import_types(AbsintheUtils.Scalars.UUID)

  query do
    @desc "Get a user by its id"
    field :user, :user do
      arg(:id, non_null(:uuid))
      resolve(&Resolvers.Accounts.user/3)
    end

    @desc "Get a product by its id"
    field :product, :product do
      arg(:id, non_null(:uuid))
      resolve(&Resolvers.Commerce.product/3)
    end

    @desc "Get a list of products"
    field :products, list_of(:product) do
      arg(:limit, :integer)
      resolve(&Resolvers.Commerce.products/3)
    end

    @desc "Get a list of orders"
    field :orders, list_of(:order) do
      arg(:limit, :integer)
      arg(:user_id, non_null(:uuid))

      resolve(&Resolvers.Commerce.orders/3)
    end
  end

  mutation do
    @desc "Create a product review"
    field :create_review, :review do
      arg(:rating, :integer)
      arg(:comments, :string)
      resolve(&Resolvers.Commerce.create_review/3)
    end

    @desc "Create an order"
    field :create_order, :order do
      arg(:user_id, non_null(:uuid))
      arg(:total, :string)
      arg(:order_items, list_of(:order_item_input))
      resolve(&Resolvers.Commerce.create_order/3)
    end

    @desc "Create a product (admin)"
    field :create_product, :product_input do
      # arg(:uuid, non_null(:string))
      arg(:name, :string)
      arg(:description, :string)
      arg(:price, :decimal)
      arg(:stock, :integer)
      resolve(&Resolvers.Commerce.create_product/3)
    end
  end

  object :product do
    field(:id, non_null(:uuid))
    field(:name, non_null(:string))
    field(:description, :string)
    field(:price, :decimal)
    field(:stock, :integer)

    field(:reviews, list_of(:review), resolve: dataloader(ShopApp.Commerce))
  end

  object :product_input do
    field(:id, non_null(:uuid))
    field(:name, non_null(:string))
    field(:description, :string)
    field(:price, :decimal)
    field(:stock, :integer)
  end

  object :user do
    field(:id, non_null(:uuid))
    field(:username, :string)
    field(:name, :string)
  end

  object :review do
    field(:id, non_null(:uuid))
    field(:rating, :integer)
    field(:comment, :string)
  end

  object :order do
    field(:id, non_null(:uuid))
    field(:user_id, non_null(:uuid))
    field(:inserted_at, :naive_datetime)
    field(:total, :decimal)

    field(:order_items, list_of(:order_item), resolve: dataloader(ShopApp.Commerce))
  end

  object :order_item do
    field(:id, non_null(:uuid))
    field(:product_id, non_null(:uuid))
    field(:quantity, :integer)
    field(:price, :decimal)
    field(:name, :string)
  end

  input_object :order_item_input do
    field(:id, non_null(:uuid))
    field(:product_id, non_null(:uuid))
    field(:quantity, :integer)
    field(:price, :decimal)
    field(:name, :string)
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(ShopApp.Repo)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(ShopApp.Commerce, source)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
