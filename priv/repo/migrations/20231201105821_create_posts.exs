defmodule Testingtest.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do

      timestamps(type: :utc_datetime)
    end
  end
end
