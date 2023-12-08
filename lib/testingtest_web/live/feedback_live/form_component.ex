defmodule TestingtestWeb.FeedbackLive.FormComponent do
  use TestingtestWeb, :live_component

  alias Testingtest.Feedbacks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage feedback records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="feedback-form"
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
          <.button phx-disable-with="Saving...">Save Feedback</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{feedback: feedback} = assigns, socket) do
    changeset = Feedbacks.change_feedback(feedback)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"feedback" => feedback_params}, socket) do
    changeset =
      socket.assigns.feedback
      |> Feedbacks.change_feedback(feedback_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"feedback" => feedback_params}, socket) do
    save_feedback(socket, socket.assigns.action, feedback_params)
  end

  defp save_feedback(socket, :edit, feedback_params) do
    case Feedbacks.update_feedback(socket.assigns.feedback, feedback_params) do
      {:ok, feedback} ->
        notify_parent({:saved, feedback})

        {:noreply,
         socket
         |> put_flash(:info, "Feedback updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_feedback(socket, :new, feedback_params) do
    case Feedbacks.create_feedback(feedback_params) do
      {:ok, feedback} ->
        notify_parent({:saved, feedback})

        {:noreply,
         socket
         |> put_flash(:info, "Feedback created successfully")
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
