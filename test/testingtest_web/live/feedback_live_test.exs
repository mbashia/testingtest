defmodule TestingtestWeb.FeedbackLiveTest do
  use TestingtestWeb.ConnCase

  import Phoenix.LiveViewTest
  import Testingtest.FeedbacksFixtures

  @create_attrs %{description: "some description", email: "some email", name: "some name", phone: "some phone", status: "some status", user_id: 42}
  @update_attrs %{description: "some updated description", email: "some updated email", name: "some updated name", phone: "some updated phone", status: "some updated status", user_id: 43}
  @invalid_attrs %{description: nil, email: nil, name: nil, phone: nil, status: nil, user_id: nil}

  defp create_feedback(_) do
    feedback = feedback_fixture()
    %{feedback: feedback}
  end

  describe "Index" do
    setup [:create_feedback]

    test "lists all feedbacks", %{conn: conn, feedback: feedback} do
      {:ok, _index_live, html} = live(conn, ~p"/feedbacks")

      assert html =~ "Listing Feedbacks"
      assert html =~ feedback.description
    end

    test "saves new feedback", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/feedbacks")

      assert index_live |> element("a", "New Feedback") |> render_click() =~
               "New Feedback"

      assert_patch(index_live, ~p"/feedbacks/new")

      assert index_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#feedback-form", feedback: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedbacks")

      html = render(index_live)
      assert html =~ "Feedback created successfully"
      assert html =~ "some description"
    end

    test "updates feedback in listing", %{conn: conn, feedback: feedback} do
      {:ok, index_live, _html} = live(conn, ~p"/feedbacks")

      assert index_live |> element("#feedbacks-#{feedback.id} a", "Edit") |> render_click() =~
               "Edit Feedback"

      assert_patch(index_live, ~p"/feedbacks/#{feedback}/edit")

      assert index_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#feedback-form", feedback: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedbacks")

      html = render(index_live)
      assert html =~ "Feedback updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes feedback in listing", %{conn: conn, feedback: feedback} do
      {:ok, index_live, _html} = live(conn, ~p"/feedbacks")

      assert index_live |> element("#feedbacks-#{feedback.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#feedbacks-#{feedback.id}")
    end
  end

  describe "Show" do
    setup [:create_feedback]

    test "displays feedback", %{conn: conn, feedback: feedback} do
      {:ok, _show_live, html} = live(conn, ~p"/feedbacks/#{feedback}")

      assert html =~ "Show Feedback"
      assert html =~ feedback.description
    end

    test "updates feedback within modal", %{conn: conn, feedback: feedback} do
      {:ok, show_live, _html} = live(conn, ~p"/feedbacks/#{feedback}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Feedback"

      assert_patch(show_live, ~p"/feedbacks/#{feedback}/show/edit")

      assert show_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#feedback-form", feedback: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/feedbacks/#{feedback}")

      html = render(show_live)
      assert html =~ "Feedback updated successfully"
      assert html =~ "some updated description"
    end
  end
end
