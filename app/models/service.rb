require 'cron_parser'
require 'securerandom'

class Service < ActiveRecord::Base
  attr_accessible :active, :description, :name, :url, :frequency

  has_one :schedule, :dependent => :destroy
  has_many :checkins, :dependent => :destroy

  default_value_for :url, SecureRandom.urlsafe_base64(12)

  # Validate that name, description, and url are set
  validates_presence_of :name, :description, :url
  validates_uniqueness_of :name, :url
  validates_length_of :url,
    :minimum => 6,
    :maximum => 24,
    :allow_blank => false

  validates_format_of :url,
    :with => /^[a-z0-9+\-_.]+$/i,
    :message => "can only contain letters, numbers, and '+, -, _, .'"

end
