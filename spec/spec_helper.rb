require 'simplecov'
require 'simplecov-console'

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start

RSpec.configure do |config|
  # config.before(:example, acceptance: true) do
  #   puts 'Running before example'
  #   dir = Dir.tmpdir + '/highcard_test_state'
  #   `rm -Rf #{dir}`
  #   `mkdir -p #{dir}`
  #   ENV['HIGHCARD_DIR'] = dir
  # end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
