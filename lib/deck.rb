require_relative 'card'

#  class deck
class Deck
  # All ranks, from 7 to ace
  # with %i %I - `:`, `,` are not needed
  # and may be unwanted in the resulting symbols
  RANKS = (7..10).to_a + %I[jack queen king ace].freeze
  # All for suits
  SUITS = %i[♥ ♦ ♣ ♠].freeze
  # SUITS = %i[hearts diamonds clubs spades].freeze

  def self.made_happy(name)
    name.upcase
  end

  # class method
  def self.all
    # For every suit paired with every rank,
    SUITS.product(RANKS).map do |suit, rank|
      # we build a Card object and add that card to the deck array using map
      Card.build(suit, rank)
    end
  end

  def deal(num_cards)
    [Card.build(:clubs, 7)] * num_cards
  end
end
