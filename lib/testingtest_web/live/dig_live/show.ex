defmodule TestingtestWeb.DigLive.Show do
  use TestingtestWeb, :live_view

  alias Testingtest.Digs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:dig, Digs.get_dig!(id))}
  end

  defp page_title(:show), do: "Show Dig"
  defp page_title(:edit), do: "Edit Dig"
end
