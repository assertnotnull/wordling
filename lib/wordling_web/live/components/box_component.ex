defmodule WordlingWeb.Components.BoxComponent do
  use WordlingWeb, :live_component

  def render(assigns) do
    ~L"""
      <div class="table mx-1">
        <div class="border-2 h-12 w-12 text-center table-cell align-middle uppercase">
          <%= @letter %>
        </div>
      </div>
    """
  end
end
