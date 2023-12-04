defmodule Testingtest.CatsTest do
  use Testingtest.DataCase

  alias Testingtest.Cats

  describe "cats" do
    alias Testingtest.Cats.Cat

    import Testingtest.CatsFixtures

    @invalid_attrs %{age: nil, career: nil, description: nil, name: nil, status: nil}

    test "list_cats/0 returns all cats" do
      cat = cat_fixture()
      assert Cats.list_cats() == [cat]
    end

    test "get_cat!/1 returns the cat with given id" do
      cat = cat_fixture()
      assert Cats.get_cat!(cat.id) == cat
    end

    test "create_cat/1 with valid data creates a cat" do
      valid_attrs = %{age: "some age", career: "some career", description: "some description", name: "some name", status: "some status"}

      assert {:ok, %Cat{} = cat} = Cats.create_cat(valid_attrs)
      assert cat.age == "some age"
      assert cat.career == "some career"
      assert cat.description == "some description"
      assert cat.name == "some name"
      assert cat.status == "some status"
    end

    test "create_cat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cats.create_cat(@invalid_attrs)
    end

    test "update_cat/2 with valid data updates the cat" do
      cat = cat_fixture()
      update_attrs = %{age: "some updated age", career: "some updated career", description: "some updated description", name: "some updated name", status: "some updated status"}

      assert {:ok, %Cat{} = cat} = Cats.update_cat(cat, update_attrs)
      assert cat.age == "some updated age"
      assert cat.career == "some updated career"
      assert cat.description == "some updated description"
      assert cat.name == "some updated name"
      assert cat.status == "some updated status"
    end

    test "update_cat/2 with invalid data returns error changeset" do
      cat = cat_fixture()
      assert {:error, %Ecto.Changeset{}} = Cats.update_cat(cat, @invalid_attrs)
      assert cat == Cats.get_cat!(cat.id)
    end

    test "delete_cat/1 deletes the cat" do
      cat = cat_fixture()
      assert {:ok, %Cat{}} = Cats.delete_cat(cat)
      assert_raise Ecto.NoResultsError, fn -> Cats.get_cat!(cat.id) end
    end

    test "change_cat/1 returns a cat changeset" do
      cat = cat_fixture()
      assert %Ecto.Changeset{} = Cats.change_cat(cat)
    end
  end
end
