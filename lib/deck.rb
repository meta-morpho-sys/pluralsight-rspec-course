require_relative 'card'
require 'typesafe_enum'

# Implements suits and pips. Based on Ruby implementation of Joshua Bloch's
# typesafe enum pattern
class Suit < TypesafeEnum::Base
  new :HEARTS
  new :CLUBS
  new :DIAMONDS
  new :SPADES

  ALL_PIPS = %i[♦️ ♠️ ❤️ ♣️].freeze

  def pip
    ALL_PIPS[ord]
  end
end

#  class deck
class Deck
  # All ranks, from 7 to ace
  # with %i %I - `:`, `,` are not needed
  # and may be unwanted in the resulting symbols
  RANKS = (7..10).to_a + %I[jack queen king ace].freeze
  # All for suits
  SUITS = Suit.to_a.map(&:pip)

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

  # Creates a deck by accessing the class method all and shuffles the cards.
  def initialize
    # puts "Shuffling now!"
    # puts Kernel.caller
    @cards = self.class.all.shuffle
  end

  def deal(num_cards)
    @cards.shift(num_cards)
  end
end
