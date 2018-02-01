module MyCustomMatcherExperiments
  extend RSpec::Matchers::DSL

  matcher :be_happy do
    match do |string|
      string.upcase == string
    end
  end

  matcher :be_a_big_number do
    match do |num|
      num > 10
    end
  end
end


module ArrayMatchers
  extend RSpec::Matchers::DSL
  matcher :be_contiguous_by do
    match do |array|
      !first_non_contiguous_pair(array)
    end

    failure_message do |array|
      '%s and %s were not contiguous' % first_non_contiguous_pair(array)
    end

    def first_non_contiguous_pair(array)
      array
        .sort_by(&block_arg)
        .each_cons(2)
        .detect { |x, y| block_arg.call(x) + 1 != block_arg.call(y) }
    end
  end
end

module BeatingMatchers
  extend RSpec::Matchers::DSL
  matcher :beat do |losing|
    match do |winning|
      HighCard.beats?(hand(winning), hand(losing))
    end

    failure_message do |winning|
      "Expected <#{hand(winning).join(' ')}> to beat  #{hand(losing).join(' ')}"
    end
  end
end

