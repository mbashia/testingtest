defmodule Testingtest.DigsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Testingtest.Digs` context.
  """

  @doc """
  Generate a dig.
  """
  def dig_fixture(attrs \\ %{}) do
    {:ok, dig} =
      attrs
      |> Enum.into(%{
        description: "some description",
        email: "some email",
        name: "some name",
        phone: "some phone",
        status: "some status",
        user_id: 42
      })
      |> Testingtest.Digs.create_dig()

    dig
  end
end
