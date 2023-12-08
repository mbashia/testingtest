defmodule Testingtest.Digs.Dig do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback" do
    field :description, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :status, :string
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(dig, attrs) do
    dig
    |> cast(attrs, [:name, :email, :phone, :description, :status, :user_id])
    |> validate_required([:name, :email, :phone, :description, :status, :user_id])
  end
end
