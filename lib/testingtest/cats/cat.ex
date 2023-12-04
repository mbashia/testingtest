defmodule Testingtest.Cats.Cat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cats" do
    field :age, :string
    field :career, :string
    field :description, :string
    field :name, :string
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cat, attrs) do
    cat
    |> cast(attrs, [:name, :age, :description, :status, :career])
    |> validate_required([:name, :age, :description, :status, :career])
  end
end
