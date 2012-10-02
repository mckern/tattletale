class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :service_id
      t.datetime :timestamp

      t.timestamps
    end
  end
end
