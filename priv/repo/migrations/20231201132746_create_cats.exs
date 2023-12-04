defmodule Testingtest.Repo.Migrations.CreateCats do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add :name, :string
      add :age, :string
      add :description, :string
      add :status, :string
      add :career, :string

      timestamps(type: :utc_datetime)
    end
  end
end
