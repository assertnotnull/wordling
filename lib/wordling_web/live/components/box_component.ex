defmodule WordlingWeb.Components.BoxComponent do
  use WordlingWeb, :live_component

  def render(assigns) do
    ~L"""
      <div class="table mx-1">
        <div class="rounded-md h-12 w-12 text-center table-cell align-middle uppercase bg-base-300">
          <%= @letter %>
        </div>
      </div>
    """
  end
end
