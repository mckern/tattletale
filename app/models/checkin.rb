class Checkin < ActiveRecord::Base
  attr_accessible :service_id, :timestamp

  belongs_to :service
end
