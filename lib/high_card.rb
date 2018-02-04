require 'deck'
require 'card'
require 'fileutils'

require 'high_card/banker'
require 'high_card/cli'

# The app
module HighCard
  def self.beats?(hand, opposing)
    winning = [hand, opposing].sort_by { |h| h.map(&:rank).sort.reverse }.last
    hand == winning
  end
end
