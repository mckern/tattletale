require 'cron_parser'
require 'securerandom'

class CronLineValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      result = CronParser.new value
    rescue Exception => e
      result = false
    end
    record.errors[attribute] << "doesn't look like a valid cron schedule" unless result
  end
end

class ControllerNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if %q[users jobs checkins].include? value.downcase
      record.errors[attribute] << "cannot overlap with a controller name"
    end
  end
end

class Job < ActiveRecord::Base
  attr_accessible :active, :description, :name, :cron_string, :url

  belongs_to :user
  has_many :checkins, :dependent => :destroy

  default_value_for :url, SecureRandom.hex

  # Validate that name, description, and url are set
  validates_presence_of :name, :description, :url, :cron_string
  validates_uniqueness_of :name, :url
  validates_length_of :url,
    :minimum => 12,
    :maximum => 32,
    :allow_blank => false

  validates_format_of :url,
    :with => /^[a-z0-9+\-_.]+$/i,
    :message => "can only contain letters, numbers, and '+, -, _, .'"

  validates :cron_string,
    :cron_line => true,
    :if => :cron_string?

  validates :url,
    :controller_name => true,
    :if => :url?

  # Scopes for convenience
  scope :descending, order("jobs.name DESC")
  scope :ascending, order("jobs.name")

  # Figure out the last and next times in this schedule
  [:last, :next].each do |name|
    define_method(name) do |date=Time.now|
      return CronParser.new(self.cron_string).send(name, date)
    end
  end

  # If there haven't been any check-ins, return false
  def has_checked_in?
    self.checkins.empty? ? false : true
  end

  def paused?
    self.active? ? false : true
  end

  # If there haven't been any check-ins, return false
  def status
    return "paused" unless self.active?
    return "pending" unless self.has_checked_in?
    return "ok" unless self.late?
    return "late"
  end

  def late?
    return false unless self.has_checked_in?

    # This is the number of seconds between each run;
    # we're using the last scheduled run as a base time,
    # and calculating the difference between that and the
    # next scheduled run from that time; this ensures
    # that the value is not subject to the drift we'd
    # see by just using last and next and the delta
    # between them.
    threshold = (self.next(self.last) - self.last).to_i

    # Math!
    ( self.last - self.last_seen ).to_i > threshold
  end

  # Return an activerecord DateTime object corresponding
  # to the time the job last checked in
  def last_seen
    return nil if self.checkins.empty?
    self.checkins.sort_by{|checkin| checkin.updated_at}.last.created_at
  end

  def start_time
    self.created_at
  end

  private
end
