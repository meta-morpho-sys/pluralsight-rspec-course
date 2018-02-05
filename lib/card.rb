# a card
class Card
  include Enumerable
  attr_reader :rank, :suit

  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end

  def self.from_string(value)
    # Gets the last character from the string
    short_suit = value[-1].to_sym

    # Map it to a suit
    suit = {
      H: :♥,
      S: :♠,
      C: :♣,
      D: :♦
    }.fetch(short_suit)

    # Map remainder to a face card, or fallback on numeric
    # face = value[-1].to_sym
    rank = {
      A: :ace,
      K: :king,
      Q: :queen,
      J: :jack
    }.fetch(value[0].to_sym) { value[0..-2].to_i }

    Card.build(suit, rank)
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

  def to_s
    # "#{rank}" + "#{suit} "
    rank.to_s + suit.to_s
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
