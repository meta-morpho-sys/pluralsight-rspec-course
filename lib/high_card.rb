# Class that decides hands
class HighCard
  def self.beats?(hand, opposing)
    hand.first.rank > opposing.first.rank
  end
end
