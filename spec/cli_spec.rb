require 'tmpdir'
require 'pty'
require 'high_card'
require 'card'
require 'round'

BIN = "File.expand_path('../../bin/play', __FILE__)".freeze

describe 'CLI', :acceptance do
  def run_app(seed = 1, &block)
    puts 'Running before example in acceptance'
    dir = Dir.tmpdir + '/highcard_test_state'
    `rm -Rf #{dir}`
    `mkdir -p #{dir}`
    ENV['HIGHCARD_DIR'] = dir
    PTY.spawn(BIN, seed.to_s, &block)
  end

  example 'it works' do
    # Launch the game, give it input and verify whether we win or lose
    # this launches a process and gives us control over input and output strings
    run_app do |output, input, pid|
      sleep 0.5
      input.write("y\n")
      sleep 0.5
      buffer = output.read_nonblock(1024)
      expect(buffer).to include('You won!').or include('You lost!')
    end
  end

  example 'betting on winning hand' do
    run_app(1) do |output, input, pid|
      sleep 0.5
      input.write("y\n")
      sleep 0.5
      buffer = output.read_nonblock(1024)
      expect(buffer).to include('You won!')
    end
  end
  # only for test isolation purposes.
  class FakeAccount
    def name; 'tester'; end
    def credit!(*_); end
    def debit!(*_); end
    def balance; end
  end


  example 'not betting on losing hand' do
    # mocking out external dependencies by creating fake methods thanks to `allow`
    # The fake methods will return `nil` whenever called.
    allow(HighCard::CLI). to receive(:puts)
    allow(HighCard::CLI). to receive(:print)
    allow(HighCard::CLI). to receive(:`).with('whoami').and_return('tester')

    allow_any_instance_of(HighCard::Bank).to receive(:accounts).and_return([
      FakeAccount.new
    ])

    # # Set up state. We pass false as parameter to .with since we don't want
    # the code to record a bet
    expect(Round).to receive(:win?).with(false, any_args).and_return true

    expect($stdin).to receive(:gets).and_return('N')

    # `puts` can be received any number of times by the spec due to the `allow`
    expect(HighCard::CLI).to receive(:puts).with('You won!')

    HighCard::CLI.run(1)
  end
end
