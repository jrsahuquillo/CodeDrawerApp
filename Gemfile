source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
gem 'mysql2', '~> 0.4.4'
# Use Puma as the app server
gem "puma", ">= 3.12.2"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.5', require: false
gem 'octicons'
gem 'octicons_helper'
gem 'devise', '~> 4.6'
gem 'redcarpet', git: 'git://github.com/vmg/redcarpet.git'
gem 'rouge', '~> 1.10', '>= 1.10.1'
gem 'unicorn'
gem 'awesome_print'
gem 'listen', '~> 3.1', '>= 3.1.5'
gem "rack", ">= 2.0.8"
gem 'markdown_checkboxes', '~> 1.0'
gem 'select2-rails'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.0.0.beta3'
end

group :test do
  gem 'capybara', '~> 3.29'
  gem 'database_cleaner'
end

group :development do
  gem 'airbrussh', require: false
  gem 'capistrano', '3.4.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', github: 'capistrano/rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-sidekiq'
  gem 'guard', '~> 2.16'
  gem 'guard-rspec', '~> 4.7'
  gem 'guard-cucumber', '~> 2.1'
  gem 'rvm1-capistrano3', require: false
  gem 'listen', '~> 3.1', '>= 3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
