require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wromoror
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Opal configs
    config.opal.method_missing = true
    config.opal.optimized_operators = true
    config.opal.arity_check = !Rails.env.production?
    config.opal.const_missing = true
    config.opal.dynamic_require_severity = :ignore
    # Websocket configs
    config.middleware.delete Rack::Lock
  end
end
