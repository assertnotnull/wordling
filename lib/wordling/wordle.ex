defmodule Wordling.Wordle do
  def initial_state(secret_letters) do
    secret_letters
    |> Enum.map(fn letter -> {:incorrect, letter} end)
  end

  def guess(player_guess, secret_word) do
    player_guess
    |> correct_pass(secret_word)
    |> partial_pass(player_guess)
  end

  def correct_pass(player_guess, secret_letters) do
    secret_letters_charlist = String.to_charlist(secret_letters)

    {result, remainders} =
      player_guess
      |> String.to_charlist()
      |> Enum.zip(initial_state(secret_letters_charlist))
      |> Enum.reduce({[], secret_letters_charlist}, fn {guess_letter, {_status, secret_letter}},
                                                       {result, remaining_letters} ->
        compare_letter(guess_letter, secret_letter, result, remaining_letters)
      end)

    {Enum.reverse(result), remainders}
  end

  def compare_letter(letter, letter, result, remaining_letters) do
    {[{:correct, to_string([letter])} | result], remaining_letters -- [letter]}
  end

  def compare_letter(guess_letter, _, result, remaining_letters) do
    {[{:incorrect, to_string(guess_letter)} | result], remaining_letters}
  end

  def partial_pass({letter_state, remainders}, player_guess) do
    {result, remainders} =
      player_guess
      |> String.to_charlist()
      |> Enum.zip(letter_state)
      |> Enum.reduce(
        {[], remainders},
        fn {guess_letter, {status, _secret_letter}}, {result, remaining_letters} ->
          partial_match(guess_letter, status, remaining_letters, result)
        end
      )

    {Enum.reverse(result), remainders}
  end

  def partial_match(guess_letter, :correct, remainders, result) do
    {[{:correct, to_string(guess_letter)} | result], remainders}
  end

  def partial_match(guess_letter, _, remainders, result) do
    cond do
      Enum.member?(remainders, guess_letter) ->
        {[{:partial, to_string(guess_letter)} | result], remainders -- [guess_letter]}

      true ->
        {[{:incorrect, to_string(guess_letter)} | result], remainders}
    end
  end

  def check_letter(guess_letter, secret_letter, secret_letters) do
    cond do
      guess_letter == secret_letter -> {:correct, to_string(guess_letter)}
      guess_letter in secret_letters -> {:partial, to_string(guess_letter)}
      true -> {:incorrect, to_string(guess_letter)}
    end
  end
end
