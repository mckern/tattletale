require 'cron_parser'
require 'securerandom'

class Service < ActiveRecord::Base
  attr_accessible :active, :description, :name, :cron_string, :url

  belongs_to :user
  has_many :checkins, :dependent => :destroy

  default_value_for :url, SecureRandom.urlsafe_base64(16)

  # Validate that name, description, and url are set
  validates_presence_of :name, :description, :url
  validates_uniqueness_of :name, :url
  validates_length_of :url,
    :minimum => 12,
    :maximum => 24,
    :allow_blank => false

  validates_format_of :url,
    :with => /^[a-z0-9+\-_.]+$/i,
    :message => "can only contain letters, numbers, and '+, -, _, .'"

  validates_presence_of :cron_string

  # Figure out the last and next times in this schedule
  [:last, :next].each do |name|
    define_method(name) do
      return CronParser.new(self.cron_string).send(name)
    end
  end

  # If there haven't been any check-ins, return false
  def has_checked_in?
    self.checkins.empty? ? false : true
  end

  # Return an activerecord DateTime object corresponding
  # to the time the service last checked in
  def last_seen
    return nil if self.checkins.empty?
    self.checkins.sort_by{|checkin| checkin.updated_at}.last.created_at
  end

  def start_time
    self.checkins.first ? self.checkins.first.created_at : nil
  end
end
