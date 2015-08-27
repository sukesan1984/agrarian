require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Agrarian
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.scoped_views = true
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.test_framework = 'rspec'
      g.helper_specs = false
      g.view_specs = false
      g.fixture_replacement :factory_girl
    end

    I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    I18n.locale = :ja
    I18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.locale = :ja
    I18n.reload!
    config.i18n.reload!

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api')]
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.autoload_paths += Dir["#{config.root}/lib"]
    config.autoload_paths += Dir["#{config.root}/lib/**"]
  end
end
