defmodule Testingtest.Digs do
  @moduledoc """
  The Digs context.
  """

  import Ecto.Query, warn: false
  alias Testingtest.Repo

  alias Testingtest.Digs.Dig

  @doc """
  Returns the list of feedback.

  ## Examples

      iex> list_feedback()
      [%Dig{}, ...]

  """
  def list_feedback do
    Repo.all(Dig)
  end

  @doc """
  Gets a single dig.

  Raises `Ecto.NoResultsError` if the Dig does not exist.

  ## Examples

      iex> get_dig!(123)
      %Dig{}

      iex> get_dig!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dig!(id), do: Repo.get!(Dig, id)

  @doc """
  Creates a dig.

  ## Examples

      iex> create_dig(%{field: value})
      {:ok, %Dig{}}

      iex> create_dig(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dig(attrs \\ %{}) do
    %Dig{}
    |> Dig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dig.

  ## Examples

      iex> update_dig(dig, %{field: new_value})
      {:ok, %Dig{}}

      iex> update_dig(dig, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dig(%Dig{} = dig, attrs) do
    dig
    |> Dig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dig.

  ## Examples

      iex> delete_dig(dig)
      {:ok, %Dig{}}

      iex> delete_dig(dig)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dig(%Dig{} = dig) do
    Repo.delete(dig)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dig changes.

  ## Examples

      iex> change_dig(dig)
      %Ecto.Changeset{data: %Dig{}}

  """
  def change_dig(%Dig{} = dig, attrs \\ %{}) do
    Dig.changeset(dig, attrs)
  end
end
