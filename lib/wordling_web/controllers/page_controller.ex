defmodule WordlingWeb.PageController do
  use WordlingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
