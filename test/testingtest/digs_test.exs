defmodule Testingtest.DigsTest do
  use Testingtest.DataCase

  alias Testingtest.Digs

  describe "feedback" do
    alias Testingtest.Digs.Dig

    import Testingtest.DigsFixtures

    @invalid_attrs %{description: nil, email: nil, name: nil, phone: nil, status: nil, user_id: nil}

    test "list_feedback/0 returns all feedback" do
      dig = dig_fixture()
      assert Digs.list_feedback() == [dig]
    end

    test "get_dig!/1 returns the dig with given id" do
      dig = dig_fixture()
      assert Digs.get_dig!(dig.id) == dig
    end

    test "create_dig/1 with valid data creates a dig" do
      valid_attrs = %{description: "some description", email: "some email", name: "some name", phone: "some phone", status: "some status", user_id: 42}

      assert {:ok, %Dig{} = dig} = Digs.create_dig(valid_attrs)
      assert dig.description == "some description"
      assert dig.email == "some email"
      assert dig.name == "some name"
      assert dig.phone == "some phone"
      assert dig.status == "some status"
      assert dig.user_id == 42
    end

    test "create_dig/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Digs.create_dig(@invalid_attrs)
    end

    test "update_dig/2 with valid data updates the dig" do
      dig = dig_fixture()
      update_attrs = %{description: "some updated description", email: "some updated email", name: "some updated name", phone: "some updated phone", status: "some updated status", user_id: 43}

      assert {:ok, %Dig{} = dig} = Digs.update_dig(dig, update_attrs)
      assert dig.description == "some updated description"
      assert dig.email == "some updated email"
      assert dig.name == "some updated name"
      assert dig.phone == "some updated phone"
      assert dig.status == "some updated status"
      assert dig.user_id == 43
    end

    test "update_dig/2 with invalid data returns error changeset" do
      dig = dig_fixture()
      assert {:error, %Ecto.Changeset{}} = Digs.update_dig(dig, @invalid_attrs)
      assert dig == Digs.get_dig!(dig.id)
    end

    test "delete_dig/1 deletes the dig" do
      dig = dig_fixture()
      assert {:ok, %Dig{}} = Digs.delete_dig(dig)
      assert_raise Ecto.NoResultsError, fn -> Digs.get_dig!(dig.id) end
    end

    test "change_dig/1 returns a dig changeset" do
      dig = dig_fixture()
      assert %Ecto.Changeset{} = Digs.change_dig(dig)
    end
  end
end
