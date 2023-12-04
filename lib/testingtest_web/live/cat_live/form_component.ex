defmodule TestingtestWeb.CatLive.FormComponent do
  use TestingtestWeb, :live_component

  alias Testingtest.Cats

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cat records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cat-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:age]} type="text" label="Age" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:career]} type="text" label="Career" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cat</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cat: cat} = assigns, socket) do
    changeset = Cats.change_cat(cat)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cat" => cat_params}, socket) do
    changeset =
      socket.assigns.cat
      |> Cats.change_cat(cat_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cat" => cat_params}, socket) do
    save_cat(socket, socket.assigns.action, cat_params)
  end

  defp save_cat(socket, :edit, cat_params) do
    case Cats.update_cat(socket.assigns.cat, cat_params) do
      {:ok, cat} ->
        notify_parent({:saved, cat})

        {:noreply,
         socket
         |> put_flash(:info, "Cat updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cat(socket, :new, cat_params) do
    case Cats.create_cat(cat_params) do
      {:ok, cat} ->
        notify_parent({:saved, cat})

        {:noreply,
         socket
         |> put_flash(:info, "Cat created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
