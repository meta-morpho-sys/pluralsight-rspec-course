# A simple implementation of how MOCKS work in RSpec
# This SETUP - VERIFY - TEARDOWN cycle with some storage of state between them
# is how MOCKS work at the core.

def setup_expectation(obj, method)
  # If we want to know whether the method was called successfully, we need
  # to raise an error that will tell us when we failed to call the method.
  # To do that we also need to store whether we expected  the method to be called
  $expectations << [obj, method]
  # This code add a method `hello` to ONLY this particular instance
  obj.singleton_class.send(:define_method, method) do
    # Let's records in a GLOBAL HASH $calls, that a `define_method` was called.
    $calls[obj] << method
  end
end

begin
  # Mock setup
  $expectations = []
  $calls = Hash.new { |h, k| h[k] = [] }

  # Test
  obj = Object.new
  setup_expectation(obj, :hello)
  obj.hello

  # Mock verification
  $expectations.each do |obj, method|
    unless $calls[obj].include? method
      raise "#{obj} did not receive :#{method} method"
    end
  end
ensure
  # Mock teardown
  $expectations.each do |obj, method|
    obj.singleton_class.send(:undef_method, method)
  end
end

obj.hello

