class User < ActiveRecord::Base
  attr_accessible :name, :email

  # Each user can own many services
  has_many :services, :dependent => :destroy

  # Validate that name, description, and url are set
  validates_presence_of :name, :email
  validates_uniqueness_of :email
end
