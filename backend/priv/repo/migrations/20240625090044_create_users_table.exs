defmodule ShopApp.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:username, :string, null: false)
      add(:email, :string, null: false)
    end
  end
end
