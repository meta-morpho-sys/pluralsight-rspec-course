require 'tmpdir'
require 'pty'
require 'high_card'
require 'bank'
require 'card'
require 'round'
require 'ui'


BIN = File.expand_path('../../bin/play', __FILE__)

describe 'acceptance', :acceptance do
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
    run_app do |output, input, _pid|
      sleep 0.5
      input.write("y\n")
      sleep 0.5
      buffer = output.read_nonblock(1024)
      expect(buffer).to include('You won!').or include('You lost!')
    end
  end
end
