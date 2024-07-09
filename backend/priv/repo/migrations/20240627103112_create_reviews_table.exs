defmodule ShopApp.Repo.Migrations.CreateReviewsTable do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:rating, :integer, null: false)
      add(:comment, :string, null: false)
      # how to use references??
      add(:product_id, :uuid, null: false)
      add(:user_id, :uuid, null: false)
      # add(:user_id, references(:users), null: false)

      timestamps()
    end
  end
end
