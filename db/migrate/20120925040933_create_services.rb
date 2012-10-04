class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, :null => false
      t.text :description
      t.string :url, :null => false
      t.integer :schedule_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
