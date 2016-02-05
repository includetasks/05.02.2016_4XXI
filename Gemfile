source 'https://rubygems.org'

# Required ruby version
ruby '2.2.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # includes RSpec itself in a wrapper to add some extra Rails-specific
  gem 'rspec-rails', '~> 3.0'
  # More useful error pages
  gem 'better_errors', '~> 2'
  gem 'binding_of_caller', '~> 0'

  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  # replaces Rails default fixtures for feeding test data to the test suite with much more preferable factories
  gem 'factory_girl_rails', '~> 4.5.0'
  # makes it easy to programatically simulate your users interactions with your web application
  gem 'capybara', '~> 2.5.0'
  # DB cleaning strategies between separate tests and transactions
  # helps make sure each spec run in RSpec begins with a clean slate,
  # by you guessed it cleaning data from the test database
  gem 'database_cleaner', '~> 1.5.0'
  # does one thing, but does it well: It opens your default web browser
  # on demand to show you what your application is rendering
  gem 'launchy', '~> 2.4.0'
  # will let us test JavaScript-based browser interactions with Capybara
  gem 'selenium-webdriver', '~> 2.48.0'
  # Generates names, email addresses, and other placeholders
  gem 'faker', '~> 1.5.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Dependency for the RailsPanel Chrome Extention (special chrome plugin for track rails activity in browser)
  gem 'meta_request', '~> 0.3.0'
end

#########################
# Backend Oriented gems #
#########################

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Working with Users and authentication
gem 'devise', '~> 3.5.0'
# Image file uploading engine
gem 'carrierwave', '~> 0.10.0'
# Annotations for Rails's units
gem 'annotate', '~> 2.7.0'
# Mail handler (SMTP service)
gem 'mailcatcher'

##########################
# Frontend Oriented gems #
##########################

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# HTML Syntax sugar (template engine)
gem 'slim-rails', '~> 3.0.0'
# Interactive Charts written on JavaScript
gem 'highstock-rails'
# MomentJS library integration
gem 'momentjs-rails', '~> 2.11.0'
# UnderscoreJS library Integration
gem 'underscore-rails'
# Materialize Fontend Framework by Google (http://getmdl.io)
gem 'material_design_lite-rails', '~> 1.0.0'
# Material Design Lite Icons
gem 'material_icons', '~> 1.0.0'
# Data transfer from your ruby code to your view javascript code
gem 'gon', '~> 6.0.0'
# Automated insertions of vendor prefixes
gem 'autoprefixer-rails', '~> 6.2.0'
