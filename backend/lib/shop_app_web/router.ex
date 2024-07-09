defmodule ShopAppWeb.Router do
  use ShopAppWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: ShopApp.Schema.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ShopApp.Schema.Schema)
  end
end
