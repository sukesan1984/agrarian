source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# mysql
gem 'mysql2'

# ユーザー認証
gem 'devise'

# dotenv
gem 'dotenv-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
 gem 'unicorn'

# use google analytics
gem 'google-analytics-rails'
gem 'annotate'

# use uikit
gem 'uikit-sass-rails', git: 'git://github.com/8398a7/uikit-sass-rails'

# use haml
gem 'haml-rails'
gem 'erb2haml'

gem 'grape', git: 'https://github.com/intridea/grape.git'

gem 'font-awesome-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'meta_request'
  gem 'better_errors'
  gem 'pry-rails'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'faker-japanese'
  gem 'parallel'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'timecop'
  gem 'spring-commands-rspec'
  gem 'json_spec'
  gem 'json_expressions'
  gem 'shoulda-matchers', require: false
  gem 'rspec-sidekiq'
  gem 'rspec-collection_matchers'
  gem 'test_after_commit'
  gem 'rubocop', require: false
  gem 'codeclimate-test-reporter', require: false
end

group :doc do
  gem 'sdoc'
end

