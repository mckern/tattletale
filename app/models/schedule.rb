class Schedule < ActiveRecord::Base
  attr_accessible :cron, :service_id

  belongs_to :service
end
