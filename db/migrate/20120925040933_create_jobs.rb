class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name, :null => false
      t.text :description
      t.string :cron_string, :null => false
      t.string :url, :null => false
      t.integer :user_id, :null => false
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
