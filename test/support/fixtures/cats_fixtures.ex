defmodule Testingtest.CatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Testingtest.Cats` context.
  """

  @doc """
  Generate a cat.
  """
  def cat_fixture(attrs \\ %{}) do
    {:ok, cat} =
      attrs
      |> Enum.into(%{
        age: "some age",
        career: "some career",
        description: "some description",
        name: "some name",
        status: "some status"
      })
      |> Testingtest.Cats.create_cat()

    cat
  end
end
