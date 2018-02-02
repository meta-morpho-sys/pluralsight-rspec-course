require 'deck'
# Class that decides hands
module HighCard
  def self.beats?(hand, opposing)
    # To get the largest value of a hand of cards to then compare them,
    # we extract all the ranks from the hand, sort them and pick the last one.
    hand.map(&:rank).sort.last > opposing.map(&:rank).sort.last
  end

  # the entire set of operations of the game goes through the command line.
  class CLI
    def self.run(seed = rand(100000), deck: Deck.new)
      Kernel.srand seed.to_i

      login = `whoami`.chomp
      bank = Bank.new(ENV.fetch('HIGHCARD_DIR', '/tmp/bank-accounts'))
      account = bank.accounts.detect { |x| x.name == login }
      # if !account
      #   puts 'Could not find bank account, you cannot play'
      #   return
      # end
      puts 'Could not find bank account, you cannot play' unless account

      hand = deck.deal(5).sort_by(&:rank).reverse
      opposing = deck.deal(5).sort_by(&:rank).reverse

      puts "Your hand is  #{hand.join(', ')}"
      print "Bet $1 to win? N/y: "
      start = Time.now
      input = $stdin.gets
      if Round.win?(input.chomp.downcase == 'y', hand, opposing)
        puts 'You won!'
        account.credit!(login, 1)
      else
        puts 'You lost!'
        account.debit!(login, 1)
      end
      puts "Opposing hand was #{opposing.join(', ')}"
      puts "Balance is #{account.balance}"
      puts "You took #{Time.now - start}s to make a decision."
    end
  end

    # what is this class?
  class Bank
    attr_reader :accounts

    def initialize(accounts)
      @accounts = accounts
    end
    # what is this class?
    class Account
      attr_reader :name, :balance

      def initialize(path, name)
        @path = path
        FileUtils.mkdir_p(path)
        @name = name
        @balance = File.read(path + "/#{name}").to_i rescue 0
      end
    end
  end
end
