class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :cron
      t.integer :service_id

      t.timestamps
    end
  end
end
