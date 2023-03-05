defmodule WordlingWeb.Components.LetterComponent do
  use WordlingWeb, :live_component

  def render(assigns) do
    ~L"""
      <button class="btn btn-primary flex flex-1 mx-1"><%= @letter %></button>
    """
  end
end
