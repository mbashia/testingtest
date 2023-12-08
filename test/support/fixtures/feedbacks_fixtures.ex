defmodule Testingtest.FeedbacksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Testingtest.Feedbacks` context.
  """

  @doc """
  Generate a feedback.
  """
  def feedback_fixture(attrs \\ %{}) do
    {:ok, feedback} =
      attrs
      |> Enum.into(%{
        description: "some description",
        email: "some email",
        name: "some name",
        phone: "some phone",
        status: "some status",
        user_id: 42
      })
      |> Testingtest.Feedbacks.create_feedback()

    feedback
  end
end
