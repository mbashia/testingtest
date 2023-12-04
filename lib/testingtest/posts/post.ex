defmodule Testingtest.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
