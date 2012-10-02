class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.string :url, :null => false
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
