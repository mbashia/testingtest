defmodule TestingtestWeb.CatLive.Show do
  use TestingtestWeb, :live_view

  alias Testingtest.Cats

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cat, Cats.get_cat!(id))}
  end

  defp page_title(:show), do: "Show Cat"
  defp page_title(:edit), do: "Edit Cat"
end
