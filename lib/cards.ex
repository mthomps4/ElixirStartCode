defmodule Cards do
  @moduledoc """
  Methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings contianing playing cards.
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hears", "Diamons"]

    # Solution 1
    # Maping Comprehension returns nested Lists
    # cards =
    #   for value <- values do
    #     for suit <- suits do
    #       "#{value} of #{suit}"
    #     end
    #   end
    #
    # List.flatten(cards)

    # Better Solution -- can pass multiple
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end #create_deck

  def shuffle(deck) do
    Enum.shuffle(deck)
  end#shuffle()

# ex_doc formatting by empty lines and correct spacing.
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` arg indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

@doc """
  Determines whether a deck contains a given card

## Examples

    iex> deck = Cards.create_deck
    iex> Cards.contains?(deck, "Ace of Spades")
    true

"""
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end#contains?

  def createHand(hand_size) do
    # Pipe Operator -- Consistent First Arguments
      Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
  end

  #Uses bits of erlang code
  def save(deck, filename) do
      binary = :erlang.term_to_binary(deck)
      File.write(filename, binary)
  end#save()

  def load(filename) do
    # Simple case of load
    # {status, binary} = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file does not exist"
    # end

    ## ["red", color] = ["red", "blue"] --> ["red", "blue"]
    # if hardcode left Required on right
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # using _varName acknowledges the pattern and lets elixir know I don't plan to use it.
      {:error, _reason} -> "That file does not exist."
    end
  end#load()

end
