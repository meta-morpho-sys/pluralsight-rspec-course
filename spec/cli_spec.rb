require 'tmpdir'
require 'pty'

# BIN = File.expand_path('../../bin/play', __FILE__)
#
describe 'CLI', :acceptance do
  def run_app(&block)
#   #   puts 'Running before example'
#   #   dir = Dir.tmpdir + '/highcard_test_state'
#   #   `rm -Rf #{dir}`
#   #   `mkdir -p #{dir}`
#   #   ENV['HIGHCARD_DIR'] = dir
  #   PTY.spawn(BIN, &block)
  end

  # example is just an alias for `it`
  example 'it works' do
    # Launch the game, give it input and verify whether we win or lose
    # this launches a process and gives us control over input and output strings
    run_app do |output, input, pid|
      sleep 0.5
      input.write("y\n")
      sleep 0.5
      buffer = output.read_nonblock(1024)
      puts buffer
      raise unless buffer.include?('You won') || buffer.include?('You lost')
    end
  end
end
