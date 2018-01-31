# Class that decides hands
class HighCard
  def self.beats?(hand, opposing)
    # To get the largest value of a hand of cards to then compare them,
    # we extract all the ranks from the hand, sort them and pick the last one.
    hand.map(&:rank).sort.last > opposing.map(&:rank).sort.last
  end
end
