require 'high_card'
require 'card'

describe 'hand rankings' do
  example 'hand with highest card wins' do
    expect(HighCard.beats?([Card.build(:hearts, 10)], \
                            [Card.build(:hearts, 9)])).to eq true
    expect(HighCard.beats?([Card.build(:hearts, 9)], \
                            [Card.build(:hearts, 10)])).to eq false
  end
end
