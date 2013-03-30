source 'https://rubygems.org'

# Avoid Rails 3.2.13, because it is horribly
# regression-filled.
gem 'rails', '= 3.2.12'

# I used MySQL because I'm lazy, but any
# RDBM will work.
gem 'mysql2'

# These are the bits needed to make this run.
# Default_value_for is because I'm lazy,
# parse-cron is the magic juice, and
# jquery rails was neded at the time.
gem 'default_value_for'
gem 'parse-cron', :require => 'cron_parser'
gem 'jquery-rails'

# I use Unicorn or Passenger. Unicorn may be
# slightly more responsive, but Passenger has
# (I think) a simpler conceptual model. Pick
# one, try it, and if you don't like it then
# use any middleware of your choice.
#
# gem 'unicorn'
gem 'passenger'

# This pig-pile of gems is used by IRB in
# `rails console`. You probably don't need
# any of them except maybe SQLite.
group :development do
  gem 'sqlite3'
  # Just about all of this stuff is unnecessary.
  gem 'awesome_print', :require => "ap"
  gem 'hirb'
  gem 'irbtools', '= 1.4.0'
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
