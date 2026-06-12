source "https://rubygems.org"

gem "rails", "~> 8.1.3"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"

# JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# CSV is a bundled gem as of Ruby 3.4; used by the admin CSV import.
gem "csv"
# HTML parsing for the Adafruit address-list importer (lib/i2c_import.rb).
gem "nokogiri"

# Authentication [https://github.com/heartcombo/devise]
gem "devise", "~> 4.9"

# Pagination [https://github.com/ddnexus/pagy]
gem "pagy", "~> 9.3"

# Background jobs [https://github.com/sidekiq/sidekiq]
gem "sidekiq", "~> 8.0"
# Redis client, used by Action Cable and Sidekiq
gem "redis", ">= 5.0"

# Loads environment variables from .env [https://github.com/bkeepers/dotenv]
gem "dotenv-rails"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Audits gems for known security defects
  gem "bundler-audit", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
