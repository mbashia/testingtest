defmodule Testingtest.FeedbacksTest do
  use Testingtest.DataCase

  alias Testingtest.Feedbacks

  describe "feedbacks" do
    alias Testingtest.Feedbacks.Feedback

    import Testingtest.FeedbacksFixtures

    @invalid_attrs %{description: nil, email: nil, name: nil, phone: nil, status: nil, user_id: nil}

    test "list_feedbacks/0 returns all feedbacks" do
      feedback = feedback_fixture()
      assert Feedbacks.list_feedbacks() == [feedback]
    end

    test "get_feedback!/1 returns the feedback with given id" do
      feedback = feedback_fixture()
      assert Feedbacks.get_feedback!(feedback.id) == feedback
    end

    test "create_feedback/1 with valid data creates a feedback" do
      valid_attrs = %{description: "some description", email: "some email", name: "some name", phone: "some phone", status: "some status", user_id: 42}

      assert {:ok, %Feedback{} = feedback} = Feedbacks.create_feedback(valid_attrs)
      assert feedback.description == "some description"
      assert feedback.email == "some email"
      assert feedback.name == "some name"
      assert feedback.phone == "some phone"
      assert feedback.status == "some status"
      assert feedback.user_id == 42
    end

    test "create_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feedbacks.create_feedback(@invalid_attrs)
    end

    test "update_feedback/2 with valid data updates the feedback" do
      feedback = feedback_fixture()
      update_attrs = %{description: "some updated description", email: "some updated email", name: "some updated name", phone: "some updated phone", status: "some updated status", user_id: 43}

      assert {:ok, %Feedback{} = feedback} = Feedbacks.update_feedback(feedback, update_attrs)
      assert feedback.description == "some updated description"
      assert feedback.email == "some updated email"
      assert feedback.name == "some updated name"
      assert feedback.phone == "some updated phone"
      assert feedback.status == "some updated status"
      assert feedback.user_id == 43
    end

    test "update_feedback/2 with invalid data returns error changeset" do
      feedback = feedback_fixture()
      assert {:error, %Ecto.Changeset{}} = Feedbacks.update_feedback(feedback, @invalid_attrs)
      assert feedback == Feedbacks.get_feedback!(feedback.id)
    end

    test "delete_feedback/1 deletes the feedback" do
      feedback = feedback_fixture()
      assert {:ok, %Feedback{}} = Feedbacks.delete_feedback(feedback)
      assert_raise Ecto.NoResultsError, fn -> Feedbacks.get_feedback!(feedback.id) end
    end

    test "change_feedback/1 returns a feedback changeset" do
      feedback = feedback_fixture()
      assert %Ecto.Changeset{} = Feedbacks.change_feedback(feedback)
    end
  end
end
