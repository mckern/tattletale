source 'https://rubygems.org'
ruby '1.9.3'

# Tattletale is a Rails3 application
gem 'rails', '~> 3.2'

## I used MySQL2 because I'm lazy and it's there,
## but any RDBM will work.
gem 'sqlite3'
# gem 'mysql2'

## These are the bits needed to make this run.
## Default_value_for is because I'm lazy,
## parse-cron is the magic juice, and
## jquery rails was needed at the time.
gem 'default_value_for'
gem 'parse-cron', :require => 'cron_parser'
gem 'acts_as_api'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'valid_email'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier', '>= 1.0.3'
end
