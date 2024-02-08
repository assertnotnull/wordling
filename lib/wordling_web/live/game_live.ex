defmodule WordlingWeb.GameLive do
  use WordlingWeb, :live_view

  alias Wordling.Wordle

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        letters: [
          ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
          ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
          ["z", "x", "c", "v", "b", "n", "m"]
        ],
        typed: Enum.into(1..6, %{}, fn x -> {x, Enum.into(1..5, [], fn _x -> "" end)} end)
      )

    {:ok, socket}
  end

  def generate_keyboard_row(letters) do
    String.split(letters, "", trim: true)
    |> Enum.into([], fn x -> [x, status: :unused] end)
  end

  def handle_event("send-letter", %{"key" => letter}, socket) do
    is_letter_valid =
      Enum.to_list(97..122)
      |> to_string()
      |> String.contains?(letter)

    if(is_letter_valid || letter == "Backspace" || letter == "Enter") do
      %{1 => first} = typed = socket.assigns.typed
      updated = Map.put(typed, 1, handle_letter(letter, first))
      socket = assign(socket, typed: updated)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_letter("Backspace", row) do
    case Enum.any?(row, fn x -> x == "" end) do
      false ->
        List.replace_at(row, 4, "")

      true ->
        List.replace_at(row, Enum.find_index(row, fn x -> x == "" end) - 1, "")
    end
  end

  def handle_letter("Enter", row) do
    word = Enum.join(row, "")
    IO.inspect(word)
    guess = Wordle.guess(word, "later")
    IO.inspect(guess)
    row
  end

  def handle_letter(letter, row) do
    case Enum.any?(row, fn x -> x == "" end) do
      false -> row
      true -> List.replace_at(row, Enum.find_index(row, fn x -> x == "" end), letter)
    end
  end
end
