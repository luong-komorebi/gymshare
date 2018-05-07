require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gymshare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.logger = Logger.new(STDOUT)
    config.log_level = :info
    config.autoload_paths << Rails.root.join('lib')
    config.after_initialize do
      Thread.new { Bot::BotServer.run_bot_server(config.logger) }
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
