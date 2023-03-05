defmodule WordlingWeb.GameLive do
  use WordlingWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        letters: [
          ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
          ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
          ["z", "x", "c", "v", "b", "n", "m"]
        ]
      )

    {:ok, socket}
  end
end
