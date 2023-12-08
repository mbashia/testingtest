defmodule TestingtestWeb.DigLive.Index do
  use TestingtestWeb, :live_view

  alias Testingtest.Digs
  alias Testingtest.Digs.Dig

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :feedback, Digs.list_feedback())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Dig")
    |> assign(:dig, Digs.get_dig!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Dig")
    |> assign(:dig, %Dig{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Feedback")
    |> assign(:dig, nil)
  end

  @impl true
  def handle_info({TestingtestWeb.DigLive.FormComponent, {:saved, dig}}, socket) do
    {:noreply, stream_insert(socket, :feedback, dig)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    dig = Digs.get_dig!(id)
    {:ok, _} = Digs.delete_dig(dig)

    {:noreply, stream_delete(socket, :feedback, dig)}
  end
end
