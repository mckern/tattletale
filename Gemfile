#ruby-1.9.3-p385-railsexpress
#ruby-gemset=tattletale

source 'https://rubygems.org'

gem 'rails', '= 3.2.12'
gem 'sqlite3'
gem 'mysql2'

# These are the bits needed to make this run
gem 'default_value_for'
gem 'parse-cron', :require => 'cron_parser'
gem 'jquery-rails'

gem 'unicorn'

# Pig-pile of gems used in IRB
group :development do
  gem 'awesome_print', :require => "ap"
  gem 'hirb'
  gem 'irbtools', '= 1.4.0'
  # gem 'looksee'
  gem 'net-http-spy'
  gem 'terminal-notifier'
  gem 'what_methods'
  gem 'wirble'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end
