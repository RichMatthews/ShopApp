defmodule ShopApp.Repo do
  use Ecto.Repo,
    otp_app: :shop_app,
    adapter: Ecto.Adapters.Postgres
end
