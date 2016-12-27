class Checkin < ActiveRecord::Base
  acts_as_api

  belongs_to :job

  validates_presence_of :job_id

  scope :last_week, lambda { where(:created_at => 1.week.ago..DateTime.now.end_of_day) }

  api_accessible :checkins_with_job do |t|
    t.add :created_at, :as => :timestamp
  end
end
