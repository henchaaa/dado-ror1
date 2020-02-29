source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.1'

# Provides UNION etc.
gem "active_record_extended", "~> 1.4"

gem "trailblazer", ">= 2.0.7", "< 2.1"
gem "trailblazer-rails", "~> 1.0.11"

# Disposable::Twin API for Reform. 0.3.2 Provides Property::Hash
gem "disposable", ">= 0.3.2" # currently ~ 0.4.4
gem "reform-rails", "~> 0.1.7" # installs Reform 2.2.4

# gem "simple_form", "~> 5.0"

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

#boorstrap
gem 'bootstrap', '~>4.4.1'
gem 'sprockets-rails', '~>2.3.2'

gem 'jquery-rails', '4.3.5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'


# Generates PDFs from HTML
gem "wicked_pdf", "~> 1.4"

# Binary for wkhtmltopdf for wicked_pdf
gem "wkhtmltopdf-binary", ">= 0.12"

# Admin interface under /admin
gem "rails_admin", "~> 2.0"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "spring-commands-rspec"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "better_errors"
  gem "binding_of_caller"

  # Style & lint
  gem "rubocop", "~> 0.79", require: false
  gem "rubocop-performance", "~> 1.5", require: false
  gem "rubocop-rails", "~> 2.4", require: false
  gem "rubocop-rspec", "~> 1.37", require: false
end

group :test do
  gem "rspec-rails", "~> 3.9"
  gem "shoulda-matchers", ">= 4.2"
  gem "simplecov", "~> 0.17"
end
