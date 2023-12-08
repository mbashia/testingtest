defmodule TestingtestWeb.DigLive.FormComponent do
  use TestingtestWeb, :live_component

  alias Testingtest.Digs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage dig records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="dig-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:user_id]} type="number" label="User" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Dig</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{dig: dig} = assigns, socket) do
    changeset = Digs.change_dig(dig)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"dig" => dig_params}, socket) do
    changeset =
      socket.assigns.dig
      |> Digs.change_dig(dig_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"dig" => dig_params}, socket) do
    save_dig(socket, socket.assigns.action, dig_params)
  end

  defp save_dig(socket, :edit, dig_params) do
    case Digs.update_dig(socket.assigns.dig, dig_params) do
      {:ok, dig} ->
        notify_parent({:saved, dig})

        {:noreply,
         socket
         |> put_flash(:info, "Dig updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_dig(socket, :new, dig_params) do
    case Digs.create_dig(dig_params) do
      {:ok, dig} ->
        notify_parent({:saved, dig})

        {:noreply,
         socket
         |> put_flash(:info, "Dig created successfully")
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
