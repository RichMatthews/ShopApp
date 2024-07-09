defmodule ShopApp.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, Ecto.UUID, autogenerate: {Uniq.UUID, :uuid7, []}}
      @foreign_key_type :binary_id
    end
  end
end
