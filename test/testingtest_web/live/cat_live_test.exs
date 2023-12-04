defmodule TestingtestWeb.CatLiveTest do
  use TestingtestWeb.ConnCase

  import Phoenix.LiveViewTest
  import Testingtest.CatsFixtures

  @create_attrs %{age: "some age", career: "some career", description: "some description", name: "some name", status: "some status"}
  @update_attrs %{age: "some updated age", career: "some updated career", description: "some updated description", name: "some updated name", status: "some updated status"}
  @invalid_attrs %{age: nil, career: nil, description: nil, name: nil, status: nil}

  defp create_cat(_) do
    cat = cat_fixture()
    %{cat: cat}
  end

  describe "Index" do
    setup [:create_cat]

    test "lists all cats", %{conn: conn, cat: cat} do
      {:ok, _index_live, html} = live(conn, ~p"/cats")

      assert html =~ "Listing Cats"
      assert html =~ cat.age
    end

    test "saves new cat", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("a", "New Cat") |> render_click() =~
               "New Cat"

      assert_patch(index_live, ~p"/cats/new")

      assert index_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cat-form", cat: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cats")

      html = render(index_live)
      assert html =~ "Cat created successfully"
      assert html =~ "some age"
    end

    test "updates cat in listing", %{conn: conn, cat: cat} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("#cats-#{cat.id} a", "Edit") |> render_click() =~
               "Edit Cat"

      assert_patch(index_live, ~p"/cats/#{cat}/edit")

      assert index_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cat-form", cat: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cats")

      html = render(index_live)
      assert html =~ "Cat updated successfully"
      assert html =~ "some updated age"
    end

    test "deletes cat in listing", %{conn: conn, cat: cat} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("#cats-#{cat.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cats-#{cat.id}")
    end
  end

  describe "Show" do
    setup [:create_cat]

    test "displays cat", %{conn: conn, cat: cat} do
      {:ok, _show_live, html} = live(conn, ~p"/cats/#{cat}")

      assert html =~ "Show Cat"
      assert html =~ cat.age
    end

    test "updates cat within modal", %{conn: conn, cat: cat} do
      {:ok, show_live, _html} = live(conn, ~p"/cats/#{cat}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cat"

      assert_patch(show_live, ~p"/cats/#{cat}/show/edit")

      assert show_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cat-form", cat: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cats/#{cat}")

      html = render(show_live)
      assert html =~ "Cat updated successfully"
      assert html =~ "some updated age"
    end
  end
end
