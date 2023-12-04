defmodule Testingtest.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
