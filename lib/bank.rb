# what is this class?
class Bank
  attr_reader :accounts

  def initialize(path)
    @accounts = load_accounts(path)
  end

  def load_accounts(_path)
    # File.read(path)
    [Account.new('tester', 0), Account.new('astarte', 10)]
  end

  # what is this class?
  class Account
    attr_reader :name, :balance

    def initialize(name, balance)
      # @path = path
      # FileUtils.mkdir_p(path)
      @name = name
      @balance = balance
        # begin
        #   File.read(path + "/#{name}").to_i
        # rescue StandardError
        #   0
        # end
    end

    def credit!(amount)
      @balance += amount
    end

    def debit!(amount)
      @balance -= amount
    end

  end
end
