source 'https://rubygems.org'
ruby '2.1.4'

gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bcrypt'
gem 'bootstrap_form'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'unicorn'
gem "sentry-raven"
gem 'paratrooper'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'fog'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'figaro'
gem 'stripe_event'



group :development do
  gem 'thin'
  gem "binding_of_caller"
  gem "letter_opener"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end
