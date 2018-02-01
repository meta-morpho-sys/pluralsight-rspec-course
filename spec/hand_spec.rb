require 'high_card'
require 'card'
require_relative 'custom_matchers'

describe 'hand rankings', :aggregate_failures do
  include BeatingMatchers

  example 'hand with highest card wins' do
    # Helper method. Given an array of strings it maps the strings and builds
    # a card from them using the from string method.
    def hand(strings)
      strings.map { |x| Card.from_string(x) }
    end

    expect(%w[10H]).to beat(%w[9H])
    expect(%w[9H]).not_to beat(%w[10H])

    expect(%w[6H 10H]).to beat(%w[11H])
    expect(%w[8H 9H]).not_to beat(%w[6H 10H])
  end
end
