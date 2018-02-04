require 'tmpdir'
require 'high_card/banker'
require 'high_card/cli'
require 'bank'
require 'card'
require 'round'
require 'ui'

describe 'CLI' do
  example 'not betting on losing hand' do
    account = instance_double(HighCard::Banker).as_null_object

    ui = instance_double(UI).as_null_object
    expect(ui).to receive(:yesno_prompt).with(/Bet \$1/).and_return false
    expect(ui).to receive(:puts).with('You won!')

    round = class_double('Round').as_stubbed_const

    expect(round).to receive(:win?).with(false, any_args).and_return true

    expect(account).to receive(:adjust!).with(1)
    HighCard::CLI.run(1, ui: ui, account: account)
  end
end
