require 'high_card'
require 'card'

describe 'hand rankings' do
  example 'hand with highest card wins' do
    # Helper method. Given an array of strings it maps the strings and builds
    # a card from them using the from string method.
    def hand(strings)
      strings.map { |x| Card.from_string(x) }
    end
    expect(HighCard.beats?(hand(%w[10H]), \
                           hand(%w[9H]))).to eq true
    expect(HighCard.beats?(hand(%w[9H]), \
                           hand(%w[10H]))).to eq false
  end
end
