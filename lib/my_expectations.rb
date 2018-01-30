# TO write implementation for EXPECTATION and EQ we need to have
# classes EXPECTATION and EQ that store @actual and @expected respectively
# and implement some methods

# Stores the ACTUAL value
class ExpectationTarget
  def initialize(actual)
    @actual = actual
  end

  # Wires the ExpectationTarget to the Matcher `EqMatcher in this case`
  def to(matcher)
    matcher.call(@actual)
  end
end


# Stores the EXPECTED value
class EqMatcher
  def initialize(expected)
    @expected = expected
  end

  # This is the method that compares the ACTUAL and the EXPECTED, and raises
  # an exception if the two don't match
  def call(actual)
    if actual != @expected
      raise "Expected #{@expected}, got #{actual}"
    end
  end
end

# Helper method that delegates to ExpectationTarget
def expect(actual)
  ExpectationTarget.new(actual)
end

# Helper method that delegates to EqMatcher
def eq(expected)
  EqMatcher.new(expected)
end
# p ExpectationTarget.new(1).to EqMatcher.new(1)
p expect(1).to eq(3)
