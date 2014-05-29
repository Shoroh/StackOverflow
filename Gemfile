source 'https://rubygems.org'

ruby "2.1.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# for Heroku
gem 'rails_12factor', group: :production

# Template
gem 'bootstrap-sass', '~> 3.1.1'
gem 'slim-rails'
gem 'select2-rails'

# For best forms
gem 'simple_form', '~> 3.1.0.rc1'
gem "nested_form"
gem "jquery-fileupload-rails"

# Faye-Websocket
gem "private_pub"
gem "thin"

# Pagination
gem 'kaminari'

# Put array to json-front
gem 'gon'

# User registration
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

# Tags
gem 'acts-as-taggable-on'

# Attach files
gem 'carrierwave'

# authenticity_token: true
gem 'remotipart'

# Stats
gem 'impressionist'

# Shows time ago on client side
gem 'rails-timeago', '~> 2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  gem 'rspec-rails', '2.14'
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem 'yard'
  gem 'rubocop', require: false
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'spring'
  gem 'minitest'
end