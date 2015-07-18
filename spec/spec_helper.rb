require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl_rails'
require 'shoulda-matchers'
require 'capybara/rspec'
require 'devise'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
