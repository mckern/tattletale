class AddUserToServices < ActiveRecord::Migration
  def up
    change_table :services do |t|
      t.integer :user_id, :after => :url, :null => false
    end
  end

  def down
    remove_column :services, :user_id
  end
end
