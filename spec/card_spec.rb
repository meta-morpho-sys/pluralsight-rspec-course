require 'card'

describe Card, :unit do
  def card(params = {})
    defaults = {
      suit: :hearts,
      rank: 7
    }
    Card.build(*defaults.merge(params).values_at(:suit, :rank))
  end

  it 'has a suit' do
    expect(card(suit: :spades).suit).to eq :spades
  end

  it 'has a rank' do
    expect(card(rank: 4).rank).to eq 4
  end

  context 'equality' do
    subject { card(suit: :spades, rank: 9) }
    describe 'comparing against self' do
      let(:other) { card(suit: :spades, rank: 9) }
      it 'is equal' do
        expect(subject).to eq other
      end

      it 'is hash equal' do
        expect(Set.new([subject, other]).size).to eq 1
      end

      context 'non equality' do
        shared_examples_for 'an unequal card' do
          it 'is not equal' do
            expect(subject).not_to eq other
          end

          it 'is not hash equal' do
            expect(Set.new([subject, other]).size).to eq 2
          end
        end

        describe 'comparing to a card of differing suit' do
          subject { card(suit: :spades, rank: 9) }
          let(:other) { card(suit: :clubs, rank: 9) }
          it_behaves_like 'an unequal card'
        end

        describe 'comparing to a card of different rank' do
          subject { card(suit: :spades, rank: 9) }
          let(:other) { card(suit: :spades, rank: 10) }
          it_behaves_like 'an unequal card'
        end
      end

    end
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      expect(card(rank: 10).rank).to be < card(rank: :jack).rank
    end
  end

  describe 'a queen' do
    it 'ranks higher than a jack' do
      jack = card(rank: :jack)
      queen = card(rank: :queen)
      expect(jack.rank).to be < queen.rank
    end
  end

  describe 'a king' do
    it 'ranks higher than a queen' do
      queen = card(rank: :queen)
      king = card(rank: :king)
      expect(queen.rank).to be < king.rank
    end
  end

  describe '.from_string' do
    it 'parses numbers' do
      expect(Card.from_string('7H')).to eq(Card.build(:hearts, 7))
    end

    it 'parses 10' do
      expect(Card.from_string('10S')).to eq(Card.build(:spades, 10))
    end

    it 'parses jack' do
      expect(Card.from_string('JC')).to eq(Card.build(:clubs, :jack))
    end

    it 'parses queen' do
      expect(Card.from_string('QD')).to eq(Card.build(:diamonds, :queen))
    end

    it 'parses king' do
      expect(Card.from_string('KC')).to eq(Card.build(:clubs, :king))
    end
  end
end
