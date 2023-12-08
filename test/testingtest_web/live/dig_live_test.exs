defmodule TestingtestWeb.DigLiveTest do
  use TestingtestWeb.ConnCase

  import Phoenix.LiveViewTest
  import Testingtest.DigsFixtures

  @create_attrs %{description: "some description", email: "some email", name: "some name", phone: "some phone", status: "some status", user_id: 42}
  @update_attrs %{description: "some updated description", email: "some updated email", name: "some updated name", phone: "some updated phone", status: "some updated status", user_id: 43}
  @invalid_attrs %{description: nil, email: nil, name: nil, phone: nil, status: nil, user_id: nil}

  defp create_dig(_) do
    dig = dig_fixture()
    %{dig: dig}
  end

  describe "Index" do
    setup [:create_dig]

    test "lists all feedback", %{conn: conn, dig: dig} do
      {:ok, _index_live, html} = live(conn, ~p"/feedback")

      assert html =~ "Listing Feedback"
      assert html =~ dig.description
    end

    test "saves new dig", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback")

      assert index_live |> element("a", "New Dig") |> render_click() =~
               "New Dig"

      assert_patch(index_live, ~p"/feedback/new")

      assert index_live
             |> form("#dig-form", dig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dig-form", dig: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedback")

      html = render(index_live)
      assert html =~ "Dig created successfully"
      assert html =~ "some description"
    end

    test "updates dig in listing", %{conn: conn, dig: dig} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback")

      assert index_live |> element("#feedback-#{dig.id} a", "Edit") |> render_click() =~
               "Edit Dig"

      assert_patch(index_live, ~p"/feedback/#{dig}/edit")

      assert index_live
             |> form("#dig-form", dig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dig-form", dig: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedback")

      html = render(index_live)
      assert html =~ "Dig updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes dig in listing", %{conn: conn, dig: dig} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback")

      assert index_live |> element("#feedback-#{dig.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#feedback-#{dig.id}")
    end
  end

  describe "Show" do
    setup [:create_dig]

    test "displays dig", %{conn: conn, dig: dig} do
      {:ok, _show_live, html} = live(conn, ~p"/feedback/#{dig}")

      assert html =~ "Show Dig"
      assert html =~ dig.description
    end

    test "updates dig within modal", %{conn: conn, dig: dig} do
      {:ok, show_live, _html} = live(conn, ~p"/feedback/#{dig}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dig"

      assert_patch(show_live, ~p"/feedback/#{dig}/show/edit")

      assert show_live
             |> form("#dig-form", dig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#dig-form", dig: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/feedback/#{dig}")

      html = render(show_live)
      assert html =~ "Dig updated successfully"
      assert html =~ "some updated description"
    end
  end
end
