require 'cron_parser'
require 'securerandom'

class CronLineValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      result = CronParser.new value
    rescue
      result = false
    end
    record.errors[attribute] << %w[doesn't look like a valid cron schedule] unless result
  end
end

class ControllerNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if %q[users jobs checkins].include? value.downcase
      record.errors[attribute] << %w[cannot overlap with a controller name]
    end
  end
end

class Job < ActiveRecord::Base
  acts_as_api

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
                      :with => /^[a-z0-9\-_.]+$/i,
                      :message => %w[can only contain letters, numbers, or periods, dashes, and underscores]

  validates :cron_string,
            :cron_line => true,
            :if => :cron_string?

  validates :url,
            :controller_name => true,
            :if => :url?

  # Scopes for convenience
  scope :descending, order('jobs.name DESC')
  scope :ascending, order('jobs.name')

  api_accessible :job do |t|
    t.add :name
    t.add :status
    t.add :description
    t.add :next_run
    t.add :last_seen
  end

  api_accessible :checkins_with_job do |t|
    t.add :name
    t.add :status
    t.add :description
    t.add :next_run
    t.add :last_seen
    t.add 'checkins.last_week', :as => :checkins
  end

  # Figure out the last and next times in this schedule
  [:last, :next].each do |name|
    # Defining default values for methods
    # created this way is "dicey":
    # http://apidock.com/ruby/Module/define_method
    define_method(name.to_sym) do |*args|
      date = args.first || DateTime.now
      runtime = CronParser.new(cron_string).send(name, date)
      Time.at runtime
    end
  end
  alias_method :next_run, :next
  alias_method :last_run, :last

  # If there haven't been any check-ins, return false
  def has_checked_in?
    checkins.empty? ? false : true
  end

  def paused?
    active? ? false : true
  end

  # If there haven't been any check-ins, return false
  def status
    return 'paused' unless active?
    return 'pending' unless has_checked_in?
    return 'ok' unless late?
    'late'
  end

  def late?
    return false unless has_checked_in?

    # This is the number of seconds between each run;
    # we're using the last scheduled run as a base time,
    # and calculating the difference between that and the
    # next scheduled run from that time; this ensures
    # that the value is not subject to the drift we'd
    # see by just using last and next and the delta
    # between them.
    threshold = (next_run(last_run) - last_run).to_i

    # Math!
    ( last_run - last_seen ).to_i > threshold
  end

  # Return a Time object corresponding
  # to the time the job last checked in
  def last_seen
    return nil if checkins.empty?
    last_checkin = checkins.sort_by { |this_checkin| this_checkin.created_at }.last
    Time.at last_checkin.created_at
  end

  def start_time
    Time.at created_at
  end

  def to_string
    name
  end
  alias_method :to_s, :to_string

  def to_param
    [id, name.parameterize].join('-')
  end
  alias_method :to_p, :to_param
end
