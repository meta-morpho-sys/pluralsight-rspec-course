# Acts like a 3rd party library
# Stores and hands out a collection of accounts
class Bank
  attr_reader :accounts

  def initialize(path)
    @accounts = load_accounts(path)
  end

  def load_accounts(_path)
    [Account.new('tester', 0), Account.new('astarte', 10)]
  end

  # Takes care of updating the balance of a user's account
  class Account
    attr_reader :name, :balance

    def initialize(name, balance)
      @name = name
      @balance = balance
    end

    def credit!(amount)
      @balance += amount
    end

    def debit!(amount)
      @balance -= amount
    end
  end
end
