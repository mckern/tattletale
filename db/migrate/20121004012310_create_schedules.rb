class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name, :null => false
      t.text :description
      t.string :cron_string, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
