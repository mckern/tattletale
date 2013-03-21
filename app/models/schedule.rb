require 'cron_parser'
class Schedule < ActiveRecord::Base
  attr_accessible :name, :description, :cron_string

  accepts_nested_attributes_for :services

  has_one :user
  has_many :services

  validates_presence_of :name, :cron_string

  # Figure out the last and next times in this schedule
  [:last, :next].each do |name|
    define_method(name) do
      return CronParser.new(self.cron_string).send(name)
    end
  end
end
