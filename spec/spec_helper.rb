require 'rspec'
require 'net/http'
require 'json'

# Load the CLI class
require_relative '../lib/hncli/cli'

RSpec.configure do |config|
  # Enable color in the output
  config.color = true

  # Use the documentation format for readability
  config.formatter = :documentation

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Use the expect syntax (instead of should)
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Disable monkey patching
  config.disable_monkey_patching!

  # Show full backtrace for errors
  config.full_backtrace = false

  # Run tests in random order to surface order dependencies.
  config.order = :random
end
