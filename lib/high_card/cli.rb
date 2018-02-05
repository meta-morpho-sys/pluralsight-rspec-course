require 'ui'
require 'deck'
require 'round'

module HighCard
  # the entire set of operations of the game goes through the command line.
  class CLI
    def self.default_account
      Banker.new(ENV.fetch('HIGHCARD_DIR', '/tmp/bank-accounts'),
                 `whoami`.chomp)
    end

    # rubocop:disable Metrics/AbcSize
    def self.run(seed = rand(100_000), deck: nil,
                 ui: UI.new, account: default_account)

      $stdout.sync = true

      puts "Seed for randomisation is set to #{seed}"
      Kernel.srand seed.to_i

      deck ||= Deck.new

      unless account.exists?
        puts 'Could not find bank account, you cannot play'
        return
      end

      hand     = deck.deal(5).sort_by(&:rank).reverse
      opposing = deck.deal(5).sort_by(&:rank).reverse

      ui.puts "Your hand is  #{hand.join(', ')}"
      start = Time.now
      input = ui.wanna_bet_prompt('Bet $1 to win?')
      if Round.win?(input, hand, opposing)
        ui.puts 'You won!'
        account.adjust!(1)
      else
        ui.puts 'You lost!'
        account.adjust!(-1)
      end
      ui.puts "Opposing hand was #{opposing.join(', ')}"
      ui.puts "Balance is #{account.balance}"
      ui.puts "You took #{Time.now - start}s to make a decision."
    end
  end
end
