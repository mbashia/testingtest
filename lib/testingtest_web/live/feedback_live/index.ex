defmodule TestingtestWeb.FeedbackLive.Index do
  use TestingtestWeb, :live_view

  alias Testingtest.Feedbacks
  alias Testingtest.Feedbacks.Feedback

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :feedbacks, Feedbacks.list_feedbacks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Feedback")
    |> assign(:feedback, Feedbacks.get_feedback!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Feedback")
    |> assign(:feedback, %Feedback{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Feedbacks")
    |> assign(:feedback, nil)
  end

  @impl true
  def handle_info({TestingtestWeb.FeedbackLive.FormComponent, {:saved, feedback}}, socket) do
    {:noreply, stream_insert(socket, :feedbacks, feedback)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    feedback = Feedbacks.get_feedback!(id)
    {:ok, _} = Feedbacks.delete_feedback(feedback)

    {:noreply, stream_delete(socket, :feedbacks, feedback)}
  end
end
