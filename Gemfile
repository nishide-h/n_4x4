# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.2"
gem "rails", "~> 5.2.0"
gem "puma", "~> 3.12"
gem "sassc-rails"
gem "uglifier", ">= 1.3.0"
# gem 'mini_racer', platforms: :ruby

gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "bootsnap", ">= 1.1.0", require: false

gem "ruby-debug-ide"
gem "debase"

gem "rails-i18n"
gem "slim-rails"
gem "html2slim"
gem "bootstrap", "~> 4.3.1"
gem "devise"
gem "awesome_print"
gem "webpacker"
gem "enum_help"
gem "kaminari"

group :development, :test do
  # gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "pry-byebug"
  gem "pry-doc"
  gem "factory_bot_rails", "~> 4.11"
  gem "sqlite3"
  gem "rubocop", require: false
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rspec-rails", "~>3.7"
  # gem "poltergeist"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem "pg"
end
