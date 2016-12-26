source 'https://rubygems.org'

# Tattletale is a Rails 4 application
gem 'rails', '~> 4.2.7'

## If you're just horsing around and you don't need something
## with any substantial availability, use Sqlite. This is the
## default value, but it is not "web scale".
gem 'sqlite3'

## Use MySQL2 if you're lazy. It'll work.
# gem 'mysql2'

## If you want an actual honest-to-goodness database,
## (or you're running this on Heroku), use Postgresql instead
# gem 'pg'

## These are the bits needed to make this run.
## Default_value_for is because I'm lazy,
## parse-cron is the magic juice, and
## jquery rails was needed at the time.
gem 'default_value_for'
gem 'parse-cron', require: 'cron_parser'
gem 'acts_as_api'
gem 'jquery-rails'
gem 'valid_email'

## Assets, assets, assets
gem 'therubyracer'
gem 'sass-rails', '~> 4.0'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

# Puma is a perfectly fine application server out of the box.
group :puma do
  gem 'puma'
end
