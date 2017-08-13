# frozen_string_literal: true

class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :job_id, null: false
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
