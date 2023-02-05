# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.4', '>= 7.0.4.1'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'

# gem 'rack-cors'

gem 'bcrypt', '~> 3.1.18'
gem 'jwt'

gem 'rswag'

group :development do
  gem 'rubocop'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag-specs'
end
