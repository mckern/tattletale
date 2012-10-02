class AddFrequencyToServices < ActiveRecord::Migration
  def change
    add_column :services, :frequency, :string
  end

  def self.down
    remove_column :services, :frequency
  end
end
