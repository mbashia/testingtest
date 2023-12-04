defmodule Testingtest.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Testingtest.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{

      })
      |> Testingtest.Posts.create_post()

    post
  end
end
