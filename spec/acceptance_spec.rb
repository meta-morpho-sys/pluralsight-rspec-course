require 'tmpdir'
require 'pty'
require 'high_card'
require 'bank'
require 'card'
require 'round'
require 'ui'

BIN = File.expand_path('../../bin/play', __FILE__)

describe 'acceptance', :acceptance do
  example 'it works once stdio buffering is taken into account' do
    # Launch the game, give it input and verify whether we win.
    # this launches a process and gives us control over input and output strings

    # See https://ruby-doc.org/stdlib-2.4.1/libdoc/pty/rdoc/PTY.html
    # for how this uses pty
    master, slave = PTY.open
    read, write = IO.pipe
    pid = PTY.spawn(BIN, '1', in: read, out: slave)

    read.close     # we dont need the read
    slave.close    # or the slave

    # ignore first few bits of output
    master.gets
    master.gets

    write.puts('y')
    buffer = master.gets
    expect(buffer).to include('You won!')
    write.close
  end
end
