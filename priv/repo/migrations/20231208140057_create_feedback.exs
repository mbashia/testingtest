defmodule Testingtest.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedback) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :description, :string
      add :status, :string
      add :user_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
