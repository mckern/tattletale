class Checkin < ActiveRecord::Base
  attr_accessible :job_id, :timestamp

  belongs_to :job

  validates_presence_of :job_id
end
