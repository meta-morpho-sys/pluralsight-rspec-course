require 'deck'
require_relative 'custom_matchers'

describe Deck do
  include ArrayMatchers
  include MyCustomMatcherExperiments

  # testing a class method
  describe '.all' do
    it 'contains 32 cards' do
      expect(Deck.all.length). to eq 32
    end

    it 'has contiguous ranks by suit' do
      # Deck.all.group_by(&:suit).each do |suit, cards|
      #   expect(cards).to be_contiguous_by(&:rank)
      expect(Deck.all.group_by(&:suit).values).to all(be_contiguous_by(&:rank))
    end

    it 'has a seven as its lowest card' do
      # # checks of the existence or not of a specific card
      ## not a property or behaviour
      # Deck::SUITS.each do |suit|
      #   expect(Deck.all).to include(Card.build(suit, 7))
      #   expect(Deck.all).to_not include(Card.build(suit, 6))
      #   # or
      #   expect(Deck.all.include?(Card.build(suit, 7))).to eq true

      # # # Testing property or behaviour
      # Deck.all.each do |card|
      #   expect(card.rank). to be >= 7
      # end

      # Nesting a matcher in the `all` matcher produces a much
      # clearer error message. For this to work we must extract just the ranks
      # from the deck. The output shows all the ranks and the specific ones
      # that VIOLATED our property.
      # The `all` mather takes another matcher as argument and applies is
      # to every element in the array
      # expect(Deck.all.map(&:rank)).to all(be >= 7)

      # Or we can use the `have_attributes` matcher that takes care of the `map`
      # method for us and says that the array should have the attribute
      # or method 'rank'.
      # This is triple nesting:
      #   -matcher `all`
      #   _matcher `have_attributes`
      #   -matcher `be >=`
      expect(Deck.all).to all(have_attributes(rank: be >= 7))
    end

    # Experiment in writing my own matcher
    it 'contains a big number of cards' do
      expect(Deck.all.length). to be_a_big_number
    end

    # Experiment in writing my own matcher
    it 'shows its happiness' do
      expect(Deck.made_happy('Alan')).to be_happy
    end
  end
end
