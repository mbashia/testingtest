defmodule Testingtest.Feedbacks.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedbacks" do
    field :description, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :status, :string
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:name, :email, :phone, :description, :status, :user_id])
    |> validate_required([:name, :email, :phone, :description, :status, :user_id])
  end
end
