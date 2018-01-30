# a card
class Card

  include Enumerable
  attr_reader :rank, :suit

  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end

  private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then 11
            when :queen then 12
            when :king then 13
            when :ace then 14
            else rank
            end
  end

  def inspect
    to_s
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def hash
    [suit, rank].hash
  end

  def eql?(other)
    self == other
  end
end
