require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module I2capp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # I2CappSearch and i2c_import are plain Ruby loaded via `require`
    # (their constant names don't match Zeitwerk's inflection), so keep them
    # out of the autoloader.
    config.autoload_lib(ignore: %w[assets tasks I2CappSearch i2c_import.rb])

    # Make lib/ requireable so `require "I2CappSearch/..."` works.
    $LOAD_PATH.unshift Rails.root.join("lib").to_s

    # Run Active Job (mailers, suggestion scanners) through Sidekiq.
    config.active_job.queue_adapter = :sidekiq

    # This app does not generate Active Storage image variants.
    config.active_storage.variant_processor = :disabled

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
  end
end
