require 'ui'

describe UI do
  subject { UI.new }
  describe '#wanna_bet_prompt?' do
    example "it return true when user chooses 'yes'" do
      allow($stdin).to receive(:gets).and_return('Y')
      expect(subject.wanna_bet?('Bet 1 $?')).to eq true
    end
    example "when user chooses 'n'" do
      allow($stdin).to receive(:gets).and_return('n')
      expect(subject.wanna_bet?('Bet 1 $?')).to eq false
    end
  end
end
