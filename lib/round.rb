# decides whether betting or not on a hand wins or loses
class Round
  def self.win?(bet, hand, opposing)
    winning = [hand, opposing]
              .sort_by { |h| h.map(&:rank).sort.reverse }
              .last
    # bet && hand == winning || !bet && opposing == winning
    # xor-ed version of the previous line
    bet ^ (opposing == winning)
  end
end
