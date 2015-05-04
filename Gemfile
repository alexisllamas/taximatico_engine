source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'carrierwave'
gem 'fog'
gem 'twilio-ruby'
gem 'yard-cucumber', group: :doc

gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'bonsai-elasticsearch-rails', group: :production

# deployment dependencies

gem 'puma'
gem 'rails_12factor', group: :production

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'cucumber-api-steps', require: false
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem "codeclimate-test-reporter", require: nil
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'faker'
  gem 'vcr'
  gem 'webmock'
end
